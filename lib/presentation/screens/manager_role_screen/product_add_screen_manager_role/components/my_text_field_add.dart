import 'package:flutter/material.dart';
import 'package:sandiq/services/constants/colors.dart';

class MyTextFieldAdd extends StatelessWidget {
  final String text;
  final IconData? icon;
  final TextInputAction action;
  final TextEditingController controller;

  const MyTextFieldAdd({
    super.key,
    this.icon,
    required this.action,
    required this.text,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      textInputAction: TextInputAction.next,
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        hintText: text,
        hintStyle: TextStyle(
          color: Colors.grey.shade500,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: CustomColors.kBlack),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.grey.shade500),
        ),
        suffixIcon: Icon(icon),
      ),
    );
  }
}
