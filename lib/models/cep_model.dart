import 'dart:convert';

class CepModel {
  String cep;
  String localidade;
  String logradouro;
  String complemento;
  String bairro;
  String uf;
  String ibge;
  String gia;
  String ddd;
  String siafi;

  CepModel(
    this.cep,
    this.localidade,
    this.logradouro,
    this.complemento,
    this.bairro,
    this.uf,
    this.ibge,
    this.gia,
    this.ddd,
    this.siafi,
  );

  factory CepModel.empty() {
    return CepModel("", "", "", "", "", "", "", "", "", "");
  }

  CepModel copyWith({
    String? cep,
    String? localidade,
    String? logradouro,
    String? complemento,
    String? bairro,
    String? uf,
    String? ibge,
    String? gia,
    String? ddd,
    String? siafi,
  }) {
    return CepModel(
      cep ?? this.cep,
      localidade ?? this.localidade,
      logradouro ?? this.logradouro,
      complemento ?? this.complemento,
      bairro ?? this.bairro,
      uf ?? this.uf,
      ibge ?? this.ibge,
      gia ?? this.gia,
      ddd ?? this.ddd,
      siafi ?? this.siafi,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'cep': cep,
      'localidade': localidade,
      'logradouro': logradouro,
      'complemento': complemento,
      'bairro': bairro,
      'uf': uf,
      'ibge': ibge,
      'gia': gia,
      'ddd': ddd,
      'siafi': siafi,
    };
  }

  factory CepModel.fromMap(Map<String, dynamic> map) {
    return CepModel(
      map['cep'] ?? '',
      map['localidade'] ?? '',
      map['logradouro'] ?? '',
      map['complemento'] ?? '',
      map['bairro'] ?? '',
      map['uf'] ?? '',
      map['ibge'] ?? '',
      map['gia'] ?? '',
      map['ddd'] ?? '',
      map['siafi'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory CepModel.fromJson(String source) =>
      CepModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CepModel(cep: $cep, localidade: $localidade, logradouro: $logradouro, complemento: $complemento, bairro: $bairro, uf: $uf, ibge: $ibge, gia: $gia, ddd: $ddd, siafi: $siafi)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CepModel &&
        other.cep == cep &&
        other.localidade == localidade &&
        other.logradouro == logradouro &&
        other.complemento == complemento &&
        other.bairro == bairro &&
        other.uf == uf &&
        other.ibge == ibge &&
        other.gia == gia &&
        other.ddd == ddd &&
        other.siafi == siafi;
  }

  @override
  int get hashCode {
    return cep.hashCode ^
        localidade.hashCode ^
        logradouro.hashCode ^
        complemento.hashCode ^
        bairro.hashCode ^
        uf.hashCode ^
        ibge.hashCode ^
        gia.hashCode ^
        ddd.hashCode ^
        siafi.hashCode;
  }
}
