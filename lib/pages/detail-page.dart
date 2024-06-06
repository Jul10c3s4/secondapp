import 'package:flutter/material.dart';
import 'package:secondapp/shared/drawer.dart';
import 'package:secondapp/shared/textComponent.dart';

class DetailPage extends StatelessWidget {
  final String nome;
  final int idade;
  final String numberPhone;
  final String image;
  final String id;

  const DetailPage(
      {super.key,
      required this.nome,
      required this.idade,
      required this.numberPhone,
      required this.image,
      required this.id});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: id,
      child: Scaffold(
        appBar: AppBar(
          title: CustomTitle.buildMainTitle(context, "Dados de $nome"),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: Image.network(
                    image.toString(),
                    height: 300,
                    width: 300,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTitle.buildTitle(context, "Nome: $nome"),
              const SizedBox(
                height: 20,
              ),
              CustomTitle.buildTitle(context, "Idade: $idade"),
              const SizedBox(
                height: 20,
              ),
              CustomTitle.buildTitle(context, "Celular: $numberPhone")
            ],
          ),
        ),
      ),
    );
  }
}
