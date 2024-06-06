import 'package:flutter/material.dart';
import 'package:secondapp/shared/textComponent.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomTitle.buildMainTitle(context, "página de perfil"),
      ),
      body: Column(
        children: [
          UserAccountsDrawerHeader(
              accountName: CustomTitle.buildTitle(context, "Julio Cesar"),
              accountEmail:
                  CustomTitle.buildSubTitle(context, 'juliocesar@gmail.com')),
          CircularPercentIndicator(
            radius: 60.0,
            lineWidth: 5.0,
            percent: 1.0,
            center: const Text("100%"),
            progressColor: Colors.green,
          ),
          CircularPercentIndicator(
            radius: 130.0,
            animation: true,
            animationDuration: 1200,
            lineWidth: 15.0,
            percent: 0.4,
            center: const Text(
              "40 hours",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
            ),
            circularStrokeCap: CircularStrokeCap.round,
            backgroundColor: Colors.yellow,
            progressColor: Colors.red,
          ),
          LinearPercentIndicator(
            width: MediaQuery.of(context).size.width - 50,
            animation: true,
            lineHeight: 20.0,
            animationDuration: 2000,
            percent: 1,
            center: const Text("100%"),
            progressColor: Colors.greenAccent,
          ),
        ],
      ),
    );
  }
}
