import 'package:battery_plus/battery_plus.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:secondapp/shared/drawer.dart';
import 'package:secondapp/shared/textComponent.dart';

class BatteryPage extends StatefulWidget {
  const BatteryPage({super.key});

  @override
  State<BatteryPage> createState() => _BatteryPageState();
}

class _BatteryPageState extends State<BatteryPage> {
  var battery = Battery();
  var levelBattery = 0;
  var statusBattery = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    battery.onBatteryStateChanged.listen((BatteryState state) {
      statusBattery = state.toString();
      setState(() {});
      print(statusBattery);
    });
    getBattery();
  }

  getBattery() async {
    levelBattery = await battery.batteryLevel;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: CustomTitle.buildMainTitle(context, "Battery status"),
        centerTitle: true,
      ),
      drawer: const DrawerComponent(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.battery_std,
            size: 60,
            color: Colors.grey,
          ),
          CustomTitle.buildTitle(
              context, "nível da bateria:  ${levelBattery.toString()}%"),
          const SizedBox(
            height: 10,
          ),
          LinearPercentIndicator(
            width: MediaQuery.of(context).size.width - 50,
            animation: true,
            lineHeight: 20.0,
            animationDuration: 2000,
            percent: levelBattery / 100,
            center: CustomTitle.buildSubTitle(context, "$levelBattery,0%"),
            progressColor: Colors.green,
          ),
          const SizedBox(
            height: 10,
          ),
          CustomTitle.buildTitle(context,
              "status da bateria:  ${statusBattery.toString() == "BatteryState.charging" ? "caregando" : "fora da tomada"}%")
        ],
      ),
    ));
  }
}
