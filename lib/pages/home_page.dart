import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:secondapp/shared/drawer.dart';
import 'package:secondapp/services/gerador_numeros_aleatorios.dart';
import 'package:easy_localization/easy_localization.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int random = 0;
  double tamanhoFonte = 20;
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(
            "APP_TITLE".tr(),
            style: GoogleFonts.pacifico(fontSize: 30),
          ),
        ),
        drawer: const DrawerComponent(),
        //O container normalmente ocupa o menor espaço possível
        body: Container(
          color: Colors.blue,
          //o colum por padrão ocupa o máximo espaço possível
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                color: Colors.yellow,
                child: Text(
                  'Font acme é uma fonte adicional que eu coloquei, pois não achei legal que ele tivesse uma fonte pacifico',
                  style: GoogleFonts.acme(fontSize: tamanhoFonte),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Fonte pacifico',
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Fonte pacifico é a fonte padrão do aplicativo',
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                color: Colors.red,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        onPressed: () {
                          setState(() {
                            tamanhoFonte++;
                          });
                        },
                        style:
                            TextButton.styleFrom(backgroundColor: Colors.green),
                        child: const Text(
                          "+",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            tamanhoFonte--;
                          });
                        },
                        style:
                            TextButton.styleFrom(backgroundColor: Colors.green),
                        child: const Text("-",
                            style: TextStyle(color: Colors.black)),
                      )
                    ]),
              ),
              const SizedBox(
                height: 50,
              ),
              const Text(
                'Numero aleatório: ',
                style: TextStyle(fontSize: 20, color: Colors.green),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                random.toString(),
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              random = GeradorNumerosAleatorios.gerarNumeroAleatorio(100);
            });
          },
          tooltip: 'Increment',
          child: const Icon(Icons.change_circle),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
