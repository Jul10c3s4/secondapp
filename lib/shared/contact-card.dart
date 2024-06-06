import 'package:flutter/material.dart';
import 'package:secondapp/pages/detail-page.dart';
import 'package:secondapp/shared/textComponent.dart';

class ContactCard extends StatelessWidget {
  final String nome;
  final int idade;
  final String numberPhone;
  final String image;
  final String id;

  const ContactCard(
      {super.key,
      required this.nome,
      required this.idade,
      required this.numberPhone,
      required this.image,
      required this.id});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailPage(
                      nome: nome,
                      idade: idade,
                      numberPhone: numberPhone,
                      image: image,
                      id: id,
                    )));
      },
      child: Hero(
        tag: id,
        child: Card(
          color: Colors.white,
          shadowColor: Colors.green,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          elevation: 15,
          child: Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 100, vertical: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        alignment: AlignmentDirectional.center,
                        width: 100,
                        height: 100,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.green,
                        ),
                        child: Image.network(
                          image.toString(),
                          fit: BoxFit.scaleDown,
                          width: 80,
                          height: 80,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTitle.buildSubTitle(context, nome.toString()),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTitle.buildSubTitle(context, idade.toString()),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTitle.buildSubTitle(context, numberPhone)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
