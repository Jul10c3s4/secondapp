import 'package:flutter/material.dart';
import 'package:secondapp/shared/contact-card.dart';
import 'package:secondapp/shared/drawer.dart';
import 'package:secondapp/shared/textComponent.dart';
import 'package:secondapp/repositories/cards_repositories.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  CardsRepositories cardsRepositories = CardsRepositories();
  var cards = <Widget>[];
  bool load = false;
  @override
  void initState() {
    // TODO: implement initState
    getCards();
    super.initState();
  }

  getCards() async {
    setState(() {
      load = true;
    });
    var result = await cardsRepositories.getContactsCards(context);
    setState(() {
      cards = result;
      load = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellowAccent,
      drawer: const DrawerComponent(),
      appBar: AppBar(
        title: CustomTitle.buildMainTitle(
          context,
          "Página de contatos",
        ),
        actions: [
          PopupMenuButton<String>(onSelected: (value) {
            if (value == "ordernar por nome") {}
            if (value == "ordernar por idade") {}
          }, itemBuilder: (BuildContext bc) {
            return <PopupMenuEntry<String>>[
              PopupMenuItem<String>(
                  value: "ordernar por nome",
                  child:
                      CustomTitle.buildSubTitle(context, "ordernar por nome")),
              PopupMenuItem<String>(
                  value: "ordernar por idade",
                  child:
                      CustomTitle.buildSubTitle(context, "ordernar por idade"))
            ];
          })
        ],
      ),
      body: load == true
          ? const LinearProgressIndicator(
              minHeight: 7,
            )
          : ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
              children: cards.map((card) => card).toList(),
            ),
    );
  }
}
