import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyTextFieldAdd extends StatelessWidget {
  final String? suffixText;
  final String? hinText;
  final TextInputAction action;
  final TextEditingController controller;

  const MyTextFieldAdd({
    super.key,
    required this.action,
    required this.controller,
    this.suffixText,
    this.hinText,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      textInputAction: TextInputAction.next,
      controller: controller,
      decoration: InputDecoration(
        isDense: true,
        alignLabelWithHint: false,
        labelStyle: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16.sp,
          color: Colors.grey.shade700,
        ),
        hintStyle: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16.sp,
          color: Colors.grey.shade700,
        ),
        suffixText: suffixText,
        hintText: hinText,
        filled: true,
        fillColor: Colors.blueGrey.shade50,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
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
