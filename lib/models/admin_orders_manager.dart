import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:loja_virtual/models/order.dart';
import 'package:loja_virtual/models/user.dart';

class AdminOrdersManager extends ChangeNotifier {
  List<Order> _orders = [];
  final Firestore firestore = Firestore.instance;
  StreamSubscription _subscription;
  User userFilter;
  List<Status> statusFilter = [Status.preparing];

  void updateAdmin({bool adminEnabled}) {
    _subscription?.cancel();
    if (adminEnabled) {
      _listenToOrders();
    }
  }

  void _listenToOrders() {
    _subscription = firestore.collection('orders').snapshots().listen((event) {
      for (final change in event.documentChanges) {
        switch (change.type) {
          case DocumentChangeType.added:
            _orders.add(Order.fromDocument(change.document));
            break;
          case DocumentChangeType.modified:
            final modifiedOrder = _orders.firstWhere((element) => element.orderID == change.document.documentID);
            modifiedOrder.updateFromDocument(change.document);
            break;
          case DocumentChangeType.removed:
            // Não preciso lidar com nenhum documento removido
            debugPrint('Deu problema sério!');
            break;
        }
      }
      notifyListeners();
    });
  }

  List<Order> get filteredOrders {
    List<Order> output = _orders.reversed.toList();
    if (userFilter != null) {
      output = output.where((element) => element.userID == userFilter.id).toList();
    }
    return output = output.where((element) => statusFilter.contains(element.status)).toList();
  }

  void setStatusFilter({Status status, bool enabled}) {
    if (enabled) {
      statusFilter.add(status);
    } else {
      statusFilter.remove(status);
    }
    notifyListeners();
  }

  void setUserFilter(User user) {
    userFilter = user;
    notifyListeners();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
