import 'package:flutter/material.dart';

class CustomTitle {
  static Widget buildMainTitle(BuildContext context, String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
    );
  }

  static Widget buildTitle(BuildContext context, String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
    );
  }

  static Widget buildTitleButton(BuildContext context, String title) {
    return Text(
      title,
      style: const TextStyle(
          color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
    );
  }

  static Widget buildSubTitle(BuildContext context, String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
    );
  }

  static Widget buildSubTitleCard(BuildContext context, String title) {
    return Text(
      title,
      style: const TextStyle(
          color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
    );
  }

  static Widget builddataTitle(BuildContext context, String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
    );
  }

  static Widget buildCancelTitle(BuildContext context, String title) {
    return Text(
      title,
      style: const TextStyle(
          fontSize: 16, color: Colors.red, fontWeight: FontWeight.w600),
    );
  }

  static Widget buildOkTitle(BuildContext context, String title) {
    return Text(
      title,
      style: const TextStyle(
          fontSize: 16, color: Colors.green, fontWeight: FontWeight.w600),
    );
  }
}
