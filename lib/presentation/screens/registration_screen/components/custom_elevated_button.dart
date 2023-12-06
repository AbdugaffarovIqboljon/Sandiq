import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomElevatedButton extends StatelessWidget {
  final String displayText;
  final void Function() onPressed;

  const CustomElevatedButton({
    super.key,
    required this.displayText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF00827B),
        fixedSize: Size(350.sp, 50.sp),
      ),
      child: Text(
        displayText,
        style: TextStyle(
          color: const Color(0xFFFFFFFF),
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
