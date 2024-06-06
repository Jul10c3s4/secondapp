import 'package:flutter/material.dart';
import 'package:secondapp/shared/Custom_buttom.dart';
import 'package:secondapp/shared/textComponent.dart';
import 'package:geolocator/geolocator.dart';

class GeolocatorPage extends StatefulWidget {
  const GeolocatorPage({super.key});

  @override
  State<GeolocatorPage> createState() => _GeolocatorPageState();
}

class _GeolocatorPageState extends State<GeolocatorPage> {
  @override
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: CustomTitle.buildMainTitle(context, "GPS"),
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: CustomButtom(
                  title:
                      CustomTitle.buildTitleButton(context, "Ver localização"),
                  color: Colors.green,
                  onPressed: () async {
                    Position position = await _determinePosition();
                    print(position);
                  }),
            )
          ],
        ),
      ),
    );
  }
}
