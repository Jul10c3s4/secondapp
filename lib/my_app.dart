import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:secondapp/pages/home_page.dart';
import 'package:easy_localization/easy_localization.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      //O theme é uma propriedade muito interessante pois é nele que conseguimos alterar todo o estilo do aplicativo em um único local.
      theme: ThemeData(
        appBarTheme: const AppBarTheme(backgroundColor: Colors.green),
        primarySwatch: Colors.green,
        textTheme: GoogleFonts.arimaTextTheme(),
      ),
      home: const MyHomePage(),
    );
  }
}
