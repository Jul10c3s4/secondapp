import 'package:flutter/material.dart';
import 'package:secondapp/shared/contact-card.dart';

class CardsRepositories {
  Future<List<ContactCard>> getContactsCards(BuildContext context) async {
    List<ContactCard> contactCards = <ContactCard>[];
    contactCards.add(const ContactCard(
        nome: "julio",
        idade: 19,
        numberPhone: "82 981717223",
        image:
            "https://www.pngall.com/wp-content/uploads/2016/04/Happy-Person-Free-Download-PNG.png",
        id: "0"));
    contactCards.add(const ContactCard(
        nome: "ana",
        idade: 20,
        numberPhone: "4343445",
        image:
            "https://gifs.eco.br/wp-content/uploads/2023/05/imagens-de-pessoa-apontando-png-5.png",
        id: "1"));
    contactCards.add(const ContactCard(
        nome: "carlos",
        idade: 24,
        numberPhone: "24435365",
        image:
            "https://www.pngall.com/wp-content/uploads/2016/04/Happy-Person-PNG-Picture.png",
        id: "2"));
    await Future.delayed(const Duration(seconds: 3));
    return contactCards;
  }
}
