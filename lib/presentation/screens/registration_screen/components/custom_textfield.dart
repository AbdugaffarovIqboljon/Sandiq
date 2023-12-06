import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomRegistrationTextField extends StatelessWidget {
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String hinText;
  final TextInputAction textInputAction;
  final TextEditingController controller;
  final formKey = GlobalKey<FormState>();
  String? Function(String?)? validator;
  bool isObscured;

  CustomRegistrationTextField({
    super.key,
    this.suffixIcon,
    required this.hinText,
    this.prefixIcon,
    required this.textInputAction,
    required this.controller,
    required this.validator,
    required this.isObscured,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isObscured,
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller,
      textInputAction: textInputAction,
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFFFBF9FC),
        isDense: false,
        hintText: hinText,
        hintStyle: const TextStyle(
          color: Color(0xFFA4A3A4),
          fontSize: 16,
          fontFamily: 'Source Sans Pro',
          fontWeight: FontWeight.w400,
          height: 0,
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(25),
          ),
          borderSide: BorderSide.none,
        ),
        enabled: true,
        prefixIcon: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: prefixIcon,
        ),
        suffixIcon: suffixIcon,
      ),
    );
  }
}
