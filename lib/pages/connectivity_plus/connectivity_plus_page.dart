import 'dart:async';

import 'package:flutter/material.dart';
import 'package:secondapp/shared/Custom_buttom.dart';
import 'package:secondapp/shared/drawer.dart';
import 'package:secondapp/shared/textComponent.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityPlusPage extends StatefulWidget {
  const ConnectivityPlusPage({super.key});

  @override
  State<ConnectivityPlusPage> createState() => _ConnectivityPlusPageState();
}

class _ConnectivityPlusPageState extends State<ConnectivityPlusPage> {
  late StreamSubscription subscription;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      print(result);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    subscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: CustomTitle.buildMainTitle(context, "Conexãoo do app"),
          centerTitle: true,
        ),
        drawer: const DrawerComponent(),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: CustomButtom(
                  title: CustomTitle.buildTitleButton(
                      context, "Verificar conexão"),
                  color: Colors.green,
                  onPressed: () async {
                    final connectivityResult =
                        await (Connectivity().checkConnectivity());
                    print(connectivityResult);
                    if (connectivityResult == ConnectivityResult.mobile) {
                      print("Conexão mobile");
                      // I am connected to a mobile network.
                    } else if (connectivityResult == ConnectivityResult.wifi) {
                      print("Conexão wi-fi");
                      // I am connected to a wifi network.
                    } else if (connectivityResult ==
                        ConnectivityResult.ethernet) {
                      // I am connected to a ethernet network.
                    } else if (connectivityResult == ConnectivityResult.none) {
                      print("Sem conexão");
                      // I am not connected to any network.
                    } else if (connectivityResult ==
                        ConnectivityResult.bluetooth) {
                      // I am connected to a bluetooth.
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }
}
