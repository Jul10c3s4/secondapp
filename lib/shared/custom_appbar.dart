import 'package:flutter/material.dart';
import 'package:secondapp/shared/textComponent.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  String title;
  CustomAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: CustomTitle.buildMainTitle(context, title),
      centerTitle: true,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(56.0);
}
