import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:loja_virtual/models/address.dart';
import 'package:loja_virtual/models/cart_manager.dart';
import 'package:loja_virtual/models/cart_product.dart';
import 'package:loja_virtual/services/cielo_payment.dart';

enum Status { canceled, preparing, transporting, delivery }

class Order {
  String orderID, payID;
  List<CartProduct> items;
  num price;
  String userID;
  Address address;
  Timestamp date;
  Status status;
  String get formatedID => '#${orderID.padLeft(6, '0')}';

  final Firestore firestore = Firestore.instance;
  DocumentReference get firestoreRef => firestore.collection('orders').document(orderID);

  Order.fromCartManager(CartManager cartManager) {
    items = List.from(cartManager.items);
    price = cartManager.totalPrice;
    userID = cartManager.user.id;
    address = cartManager.address;
    status = Status.preparing;
  }

  Order.fromDocument(DocumentSnapshot doc) {
    orderID = doc.documentID;
    items = (doc.data['items'] as List<dynamic>).map((e) => CartProduct.fromMap(e)).toList();
    price = doc.data['price'] as num;
    userID = doc.data['user'] as String;
    address = Address.fromMap(doc.data['address'] as Map<String, dynamic>);
    date = doc.data['date'] as Timestamp;
    status = Status.values[doc.data['status'] as int];
    payID = doc.data['payID'] as String;
  }

  Future<void> save() async {
    firestore.collection('orders').document(orderID).setData({
      'items': items.map((e) => e.toOrderItemMap()).toList(),
      'price': price,
      'user': userID,
      'address': address.toMap(),
      'status': status.index,
      'date': Timestamp.now(),
      'payID': payID,
    });
  }

  void updateFromDocument(DocumentSnapshot document) {
    status = Status.values[document.data['status'] as int];
  }

  String get statusText => getStatusText(status);

  static String getStatusText(Status status) {
    switch (status) {
      case Status.canceled:
        return 'Cancelado';
        break;
      case Status.preparing:
        return 'Em preparação';
        break;
      case Status.transporting:
        return 'Em transporte';
        break;
      case Status.delivery:
        return 'Entregue';
        break;
      default:
        return '';
    }
  }

  Function() get back {
    return (status.index >= Status.transporting.index)
        ? () {
            status = Status.values[status.index - 1];
            firestoreRef.updateData({'status': status.index});
          }
        : null;
  }

  Function() get advance {
    return (status.index <= Status.transporting.index)
        ? () {
            status = Status.values[status.index + 1];
            firestoreRef.updateData({'status': status.index});
          }
        : null;
  }

  Future<void> cancel() async {
    try {
      await CieloPayment().cancel(payID);
      status = Status.canceled;
      firestoreRef.updateData({'status': status.index});
    } catch (e) {
      debugPrint('Erro ao cancelar');
      return Future.error('Falha ao cancelar');
    }
  }

  @override
  String toString() {
    return 'Order{orderID: $orderID, items: $items, price: $price, userID: $userID, address: $address, date: $date, firestore: $firestore}';
  }
}
