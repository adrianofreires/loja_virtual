import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:loja_virtual/models/cart_manager.dart';
import 'package:loja_virtual/models/credit_card.dart';
import 'package:loja_virtual/models/order.dart';
import 'package:loja_virtual/models/product.dart';
import 'package:loja_virtual/services/cielo_payment.dart';

class CheckoutManager extends ChangeNotifier {
  CartManager cartManager;

  bool _loading = false;

  bool get loading => _loading;

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  final Firestore firestore = Firestore.instance;
  final CieloPayment cieloPayment = CieloPayment();

  void updateCart(CartManager cartManager) {
    this.cartManager = cartManager;
  }

  Future<void> checkout({CreditCard creditCard, Function onStockFail, Function onSuccess, Function onPayFail}) async {
    loading = true;
    print(creditCard.toJson());
    final orderID = await _getOrderID();

    String payID;
    try {
      payID = await cieloPayment.authorize(
        creditCard: creditCard,
        price: cartManager.totalPrice,
        orderID: orderID.toString(),
        user: cartManager.user,
      );
      debugPrint('success $payID');
    } catch (e) {
      onPayFail(e);
      loading = false;
      return;
    }
    try {
      await _decrementStock();
    } catch (e) {
      onStockFail(e);
      loading = false;
      return;
    }

    try {
      await cieloPayment.capture(payID);
      print('captura com sucesso');
    } catch (e) {
      onPayFail(e);
      loading = false;
      return;
    }

    final order = Order.fromCartManager(cartManager);
    order.orderID = orderID.toString();
    order.payID = payID;

    await order.save();
    cartManager.clear();
    onSuccess(order);
    loading = false;
  }

  Future<int> _getOrderID() async {
    final ref = firestore.document('auxiliar/ordercounter');
    try {
      final result = await firestore.runTransaction((transaction) async {
        final doc = await transaction.get(ref);
        final orderID = doc.data['current'] as int;
        await transaction.update(ref, {'current': orderID + 1});
        return {'orderID': orderID};
      });
      return result['orderID'] as int;
    } catch (e) {
      debugPrint(e.toString());
      return Future.error('Falha ao gerar número do pedido');
    }
  }

  Future<void> _decrementStock() {
    //1. Ler todos os estoques
    //2. Decrementar localmente os estoques
    //3. Atualizar os estoques no firebase
    return firestore.runTransaction((transaction) async {
      final List<Product> productsToUpdate = [];
      final List<Product> productsWithoutStock = [];
      for (final cartProduct in cartManager.items) {
        Product product;

        if (productsToUpdate.any((element) => element.id == cartProduct.productId)) {
          product = productsToUpdate.firstWhere((element) => element.id == cartProduct.productId);
        } else {
          final doc = await transaction.get(firestore.document('products/${cartProduct.productId}'));
          product = Product.fromDocument(doc);
        }
        cartProduct.product = product;

        final size = product.findSize(cartProduct.size);
        if (size.stock - cartProduct.quantity < 0) {
          productsWithoutStock.add(product);
        } else {
          size.stock -= cartProduct.quantity;
          productsToUpdate.add(product);
        }
      }
      if (productsWithoutStock.isNotEmpty) {
        return Future.error('${productsWithoutStock.length} produtos sem estoque');
      }
      for (final product in productsToUpdate) {
        transaction.update(firestore.document('products/${product.id}'), {'sizes': product.exportSizeList()});
      }
    });
  }
}
