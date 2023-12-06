import 'package:flutter/material.dart';

class ProductAddTextField extends StatelessWidget {
  final String hinText;
  final TextEditingController textEditingController;
  final TextInputAction textInputAction;
  final void Function(String)? onSubmitted;

  const ProductAddTextField({
    super.key,
    required this.hinText,
    required this.textEditingController,
    this.onSubmitted,
    required this.textInputAction,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      textInputAction: textInputAction,
      onSubmitted: onSubmitted,
      controller: textEditingController,
      decoration: InputDecoration(
        isDense: true,
        hintText: hinText,
        filled: true,
        fillColor: Colors.blueGrey.shade50,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
          borderSide: BorderSide.none,
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
