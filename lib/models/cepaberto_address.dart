class CepAbertoAddress {
  final double altitude;
  final String cep;
  final double latitude;
  final double longitude;
  final String lougradouro;
  final String bairro;
  final Cidade cidade;
  final Estado estado;

  CepAbertoAddress.fromJson(Map<String, dynamic> map)
      : altitude = map['altitude'] as double,
        cep = map['cep'] as String,
        latitude = double.tryParse(map['latitude'] as String),
        longitude = double.tryParse(map['longitude'] as String),
        lougradouro = map['lougradouro'] as String,
        bairro = map['bairro'] as String,
        cidade = Cidade.fromJson(map['cidade'] as Map<String, dynamic>),
        estado = Estado.fromJson(map['estado'] as Map<String, dynamic>);

  @override
  String toString() {
    return 'CepAbertoAddress{altitude: $altitude, cep: $cep, latitude: $latitude, longitude: $longitude, lougradouro: $lougradouro, bairro: $bairro, cidade: $cidade, estado: $estado}';
  }
}

class Cidade {
  final int ddd;
  final String ibge;
  final String nome;

  Cidade.fromJson(Map<String, dynamic> map)
      : ddd = map['ddd'] as int,
        ibge = map['ibge'] as String,
        nome = map['nome'] as String;

  @override
  String toString() {
    return 'Cidade{ddd: $ddd, ibge: $ibge, nome: $nome}';
  }
}

class Estado {
  final String sigla;

  Estado.fromJson(Map<String, dynamic> map) : sigla = map['sigla'] as String;

  @override
  String toString() {
    return 'Estado{sigla: $sigla}';
  }
}
