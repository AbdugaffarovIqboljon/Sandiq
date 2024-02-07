import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductAddTextField extends StatelessWidget {
  final String? hinText;
  final String? suffixText;
  final String? prefixText;
  final String? labelText;
  final TextEditingController textEditingController;
  final TextInputAction textInputAction;
  final void Function(String)? onSubmitted;

  const ProductAddTextField({
    super.key,
    required this.textEditingController,
    this.onSubmitted,
    required this.textInputAction,
    this.suffixText,
    this.prefixText,
    this.labelText,
    this.hinText,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      textInputAction: textInputAction,
      onSubmitted: onSubmitted,
      controller: textEditingController,
      decoration: InputDecoration(
        prefixText: prefixText,
        isDense: true,
        hintText: hinText,
        labelText: labelText,
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
