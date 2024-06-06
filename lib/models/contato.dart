import 'dart:convert';

class Contato {
  final String nome;
  final int idade;
  final String numberPhone;
  final String image;

  Contato({
    required this.nome,
    required this.idade,
    required this.numberPhone,
    required this.image,
  });

  Contato copyWith({
    String? nome,
    int? idade,
    String? numberPhone,
    String? image,
  }) {
    return Contato(
      nome: nome ?? this.nome,
      idade: idade ?? this.idade,
      numberPhone: numberPhone ?? this.numberPhone,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'idade': idade,
      'numberPhone': numberPhone,
      'image': image,
    };
  }

  factory Contato.fromMap(Map<String, dynamic> map) {
    return Contato(
      nome: map['nome'] ?? '',
      idade: map['idade']?.toInt() ?? 0,
      numberPhone: map['numberPhone'] ?? '',
      image: map['image'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Contato.fromJson(String source) =>
      Contato.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Contato(nome: $nome, idade: $idade, numberPhone: $numberPhone, image: $image)';
  }
}
