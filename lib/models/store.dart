import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/models/address.dart';
import 'package:loja_virtual/helpers/extension.dart';

enum StoreStatus { close, open, closing }

class Store {
  String name, image, phone;
  Address address;
  StoreStatus status;
  Map<String, Map<String, TimeOfDay>> opening;
  String get addressText =>
      '${address.street}, ${address.number} ${address.complement.isNotEmpty ? '-${address.complement}' : ''}\n'
      '${address.district}, ${address.city}, ${address.state}';

  String get openingText {
    return 'Seg - Sex: ${formattedPeriod(opening['monfri'])}\n'
        'Sab: ${formattedPeriod(opening['saturday'])}\n'
        'Domg: ${formattedPeriod(opening['sunday'])}';
  }

  String get cleanPhone => phone.replaceAll(RegExp(r"[^\d]"), ""); //Remove todos os caracteres mas mantem os dígitos

  String formattedPeriod(Map<String, TimeOfDay> period) {
    if (period == null) return 'Fechado';
    return '${period['from'].formatted()} - ${period['to'].formatted()}';
  }

  Store.fromDocument(DocumentSnapshot document) {
    name = document.data['name'] as String;
    image = document.data['image'] as String;
    phone = document.data['phone'] as String;
    address = Address.fromMap(document.data['address'] as Map<String, dynamic>);
    opening = (document.data['opening'] as Map<String, dynamic>).map((key, value) {
      final timeString = value as String;
      if (timeString != null && timeString.isNotEmpty) {
        final splitted = timeString.split(RegExp(r"[:-]"));
        return MapEntry(key, {
          "from": TimeOfDay(hour: int.parse(splitted[0]), minute: int.parse(splitted[1])),
          "to": TimeOfDay(hour: int.parse(splitted[2]), minute: int.parse(splitted[3])),
        });
      } else {
        return MapEntry(key, null);
      }
    });
    updateStatus();
  }

  void updateStatus() {
    final weekDay = DateTime.now().weekday;
    Map<String, TimeOfDay> period;
    if (weekDay >= 1 && weekDay <= 5) {
      period = opening['monfri'];
    } else if (weekDay == 6) {
      period = opening['saturday'];
    } else {
      period = opening['sunday'];
    }

    final now = TimeOfDay.now();
    if (period == null) {
      status = StoreStatus.close;
    } else if (period['from'].toMinutes() < now.toMinutes() && period['to'].toMinutes() - 15 > now.toMinutes()) {
      status = StoreStatus.open;
    } else if (period['from'].toMinutes() < now.toMinutes() && period['to'].toMinutes() > now.toMinutes()) {
      status = StoreStatus.closing;
    } else {
      status = StoreStatus.close;
    }
  }

  String get statusText {
    switch (status) {
      case StoreStatus.close:
        return 'Fechada';
      case StoreStatus.closing:
        return 'Fechando';
      case StoreStatus.open:
        return 'Aberto';
      default:
        return '';
    }
  }
}
