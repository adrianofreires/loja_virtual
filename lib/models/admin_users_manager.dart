import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:loja_virtual/models/user.dart';
import 'package:loja_virtual/models/user_manager.dart';

class AdminUsersManager extends ChangeNotifier {
  List<User> users = [];

  final Firestore firestore = Firestore.instance;
  StreamSubscription _streamSubscription;

  void updateUser(UserManager userManager) {
    _streamSubscription?.cancel();
    if (userManager.adminEnabled) {
      _listenToUsers();
    } else{
      users.clear();
      notifyListeners();
    }
  }

  void _listenToUsers() {
    _streamSubscription = firestore.collection('users').snapshots().listen((snapshot) {
      users = snapshot.documents.map((e) => User.fromDocument(e)).toList();
      users.sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
      notifyListeners();
    });
  }

  List<String> get names => users.map((e) => e.name).toList();

  @override
  void dispose(){
    _streamSubscription?.cancel();
    super.dispose();
  }
}
