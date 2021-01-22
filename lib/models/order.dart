import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loja_virtual/models/address.dart';
import 'package:loja_virtual/models/cart_manager.dart';
import 'package:loja_virtual/models/cart_product.dart';

class Order {
  String orderID;
  List<CartProduct> items;
  num price;
  String userID;
  Address address;
  Timestamp date;

  final Firestore firestore = Firestore.instance;

  Order.fromCartManager(CartManager cartManager) {
    items = List.from(cartManager.items);
    price = cartManager.totalPrice;
    userID = cartManager.user.id;
    address = cartManager.address;
  }

  Future<void> save() async {
    firestore.collection('orders').document(orderID).setData({
      'items': items.map((e) => e.toOrderItemMap()).toList(),
      'price': price,
      'user': userID,
      'address': address.toMap(),
    });
  }
}
