import 'package:flutter/material.dart';
import 'package:secondapp/shared/textComponent.dart';

class CustomTextField extends StatelessWidget {
  int? maxLength;
  String title;
  TextEditingController controller;
  String hintText;
  TextInputType? inputType;

  CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.title,
    this.inputType,
    this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTitle.buildSubTitle(context, title),
        const SizedBox(
          height: 5,
        ),
        TextField(
          maxLength: maxLength,
          keyboardType: inputType ?? TextInputType.text,
          controller: controller,
          style: const TextStyle(fontSize: 20, color: Colors.black),
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            contentPadding: const EdgeInsets.only(left: 10),
            hintText: hintText,
            hintStyle: const TextStyle(color: Colors.black),
          ),
        ),
      ],
    );
  }
}
