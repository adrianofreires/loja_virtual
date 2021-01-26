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
  String get formatedID => '#${orderID.padLeft(6, '0')}';

  final Firestore firestore = Firestore.instance;

  Order.fromCartManager(CartManager cartManager) {
    items = List.from(cartManager.items);
    price = cartManager.totalPrice;
    userID = cartManager.user.id;
    address = cartManager.address;
  }

  Order.fromDocument(DocumentSnapshot doc) {
    orderID = doc.documentID;
    items = (doc.data['items'] as List<dynamic>).map((e) => CartProduct.fromMap(e)).toList();
    price = doc.data['price'] as num;
    userID = doc.data['user'] as String;
    address = Address.fromMap(doc.data['address'] as Map<String, dynamic>);
    date = doc.data['date'] as Timestamp;
  }

  Future<void> save() async {
    firestore.collection('orders').document(orderID).setData({
      'items': items.map((e) => e.toOrderItemMap()).toList(),
      'price': price,
      'user': userID,
      'address': address.toMap(),
    });
  }

  @override
  String toString() {
    return 'Order{orderID: $orderID, items: $items, price: $price, userID: $userID, address: $address, date: $date, firestore: $firestore}';
  }
}
