import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Column buildEmptyProductCase() {
  return Column(
    children: [
      Image(
        image: const AssetImage(
          "assets/images/img_empty_box.png",
        ),
        height: 120.sp,
        width: 120.sp,
      ),
      SizedBox(height: 20.sp),
      Text(
        "Qo'shilgan maxsulotlar shu yerda ko'rinadi",
        style: TextStyle(
          fontWeight: FontWeight.w200,
          fontSize: 16.sp,
          color: Colors.black87,
        ),
        textAlign: TextAlign.center,
      ),
    ],
  );
}
