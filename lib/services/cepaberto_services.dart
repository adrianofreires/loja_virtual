import 'dart:io';

import 'package:dio/dio.dart';
import 'package:loja_virtual/models/cepaberto_address.dart';

const token = '8ec606eb91163f7e46bc8cc8dce30eda';

class CepAbertoServices {
  Future<CepAbertoAddress> getAddressFromCep(String cep) async {
    final cleanCep = cep.replaceAll('.', '').replaceAll('-', '');
    final endPoint = 'https://www.cepaberto.com/api/v3/cep?cep=$cleanCep';
    final Dio dio = Dio();
    dio.options.headers[HttpHeaders.authorizationHeader] = 'Token token=$token';

    try {
      final response = await dio.get<Map<String, dynamic>>(endPoint);
      if (response.data.isEmpty) {
        return Future.error('CEP Inválido');
      }
      final CepAbertoAddress address = CepAbertoAddress.fromJson(response.data);
      return address;
    } on DioError catch (e) {
      return Future.error('Erro ao buscar CEP');
    }
  }
}
