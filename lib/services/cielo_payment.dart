import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:loja_virtual/models/credit_card.dart';
import 'package:loja_virtual/models/user.dart';
import 'package:cloud_functions/cloud_functions.dart';

class CieloPayment {
  Future<String> authorize({CreditCard creditCard, num price, String orderID, User user}) async {
    try {
      final Map<String, dynamic> dataSale = {
        'merchantOrderId': orderID,
        'amount': (price * 100).toInt(),
        'softDescriptor': 'Loja Adriano',
        'installments': 1,
        'creditCard': creditCard.toJson(),
        'cpf': user.cpf,
        'paymentType': 'CreditCard',
      };
      final HttpsCallable callable = CloudFunctions.instance.getHttpsCallable(functionName: 'authorizeCreditCard');
      callable.timeout = const Duration(seconds: 60);
      final response = await callable.call(dataSale);
      final data = Map<String, dynamic>.from(response.data as LinkedHashMap);
      if (data['success'] as bool) {
        return data['paymentId'] as String;
      } else {
        debugPrint('${data['error']['message']}');
        return Future.error(data['error']['message']);
      }
    } catch (e) {
      debugPrint('$e');
      return Future.error('Falha ao processar a transação... Tente novamente');
    }
  }

  Future<void> capture(String payID) async {
    final Map<String, dynamic> captureData = {"payID": payID};
    final HttpsCallable callable = CloudFunctions.instance.getHttpsCallable(functionName: 'captureCreditCard');
    callable.timeout = const Duration(seconds: 60);
    final response = await callable.call(captureData);
    final data = Map<String, dynamic>.from(response.data as LinkedHashMap);
    if (data['success'] as bool) {
      debugPrint('Captura realizada com sucesso');
    } else {
      debugPrint('${data['error']['message']}');
      return Future.error(data['error']['message']);
    }
  }

  Future<void> cancel(String payID) async {
    final Map<String, dynamic> cancelData = {"payID": payID};
    final HttpsCallable callable = CloudFunctions.instance.getHttpsCallable(functionName: 'cancelCreditCard');
    callable.timeout = const Duration(seconds: 60);
    final response = await callable.call(cancelData);
    final data = Map<String, dynamic>.from(response.data as LinkedHashMap);
    if (data['success'] as bool) {
      debugPrint('Cancelamento realizado com sucesso');
    } else {
      debugPrint('${data['error']['message']}');
      return Future.error(data['error']['message']);
    }
  }
}
