import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductAddTextField extends StatelessWidget {
  final String hinText;
  final String? suffixText;
  final TextEditingController textEditingController;
  final TextInputAction textInputAction;
  final void Function(String)? onSubmitted;

  const ProductAddTextField({
    super.key,
    required this.hinText,
    required this.textEditingController,
    this.onSubmitted,
    required this.textInputAction,
    this.suffixText,
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
        hintStyle: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16.sp,
          color: Colors.grey.shade700,
        ),
        suffixText: suffixText,
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
