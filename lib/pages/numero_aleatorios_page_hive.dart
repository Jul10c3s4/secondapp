import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:secondapp/shared/drawer.dart';
import 'package:secondapp/shared/textComponent.dart';

class NumerosAletorioPage extends StatefulWidget {
  const NumerosAletorioPage({super.key});

  @override
  State<NumerosAletorioPage> createState() => _NumerosAletorioPageState();
}

class _NumerosAletorioPageState extends State<NumerosAletorioPage> {
  int randomNumber = 0;
  int quantClicks = 0;
  late Box boxNumerosAleatorios;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  getData() async {
    if (Hive.isBoxOpen("box_numeros_aleatorios")) {
      boxNumerosAleatorios = Hive.box('box_numeros_aleatorios');
    } else {
      boxNumerosAleatorios = await Hive.openBox('box_numeros_aleatorios');
    }
    randomNumber = boxNumerosAleatorios.get("randomNumber") ?? 0;
    quantClicks = boxNumerosAleatorios.get("quantClicks") ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              randomNumber = Random().nextInt(1000);
              quantClicks++;
            });
            boxNumerosAleatorios.put("randomNumber", randomNumber);
            boxNumerosAleatorios.put("quantClicks", quantClicks);
          },
          child: const Icon(Icons.add),
        ),
        drawer: const DrawerComponent(),
        appBar: AppBar(
          title: CustomTitle.buildMainTitle(context, "Número aletórios"),
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomTitle.buildTitle(context, randomNumber.toString()),
              const SizedBox(
                height: 5,
              ),
              CustomTitle.buildTitle(
                  context, "quantidade de clicks: $quantClicks"),
            ],
          ),
        ),
      ),
    );
  }
}
