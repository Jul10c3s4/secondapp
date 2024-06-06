import 'package:flutter/material.dart';
import 'package:secondapp/pages/login_page.dart';
import 'package:secondapp/shared/textComponent.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    // TODO: implement initState
    loadPage();
    super.initState();
  }

  void loadPage() async {
    await Future.delayed(const Duration(seconds: 10));
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const LoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomTitle.buildTitle(context, "carregando dados"),
                //usar o widget abaixo para criar splash screens mais bonitas pois ele anima o texto
                AnimatedTextKit(
                  repeatForever: true,
                  animatedTexts: [
                    WavyAnimatedText('...',
                        textStyle: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600)),
                  ],
                  isRepeatingAnimation: true,
                  onTap: () {
                    print("Tap Event");
                  },
                ),
              ],
            ),
          ],
        )),
      ),
    );
  }
}
