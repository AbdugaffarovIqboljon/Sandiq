import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sandiq/services/constants/colors.dart';

class AddScreenManagerButton extends StatelessWidget {
  final void Function()? onPressed;
  final String displayText;
  final double width;
  final double fontSize;

  const AddScreenManagerButton({
    super.key,
    this.onPressed,
    required this.displayText,
    required this.width,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        fixedSize: Size(width, 60.sp),
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        backgroundColor: CustomColors.kPrimaryColor,
      ),
      child: Text(
        displayText,
        style: TextStyle(
          fontSize: fontSize,
          color: CustomColors.kWhite,
          fontWeight: FontWeight.w600,
          letterSpacing: .5,
        ),
      ),
    );
  }
}
