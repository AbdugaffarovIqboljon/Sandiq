import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Drawer buildDrawer(String name, String phone, void Function() onPressed) {
  return Drawer(
    clipBehavior: Clip.antiAliasWithSaveLayer,
    elevation: 0,
    backgroundColor: const Color(0xFF00827B),
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 80),

          /// #Header Profile Img
          CircleAvatar(
            radius: 60.sp,
            backgroundImage: const AssetImage(
              "assets/images/img_user_image_circle.png",
            ),
          ),

          const SizedBox(height: 15),
          const Divider(),
          const SizedBox(height: 15),

          /// #Name
          Text(
            "Name: $name",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 18.sp,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),

          /// #Phone
          Text(
            "Phone: $phone",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 18.sp,
              color: Colors.white,
            ),
          ),
          const Spacer(flex: 12),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 10,
              backgroundColor: Colors.red.shade400,
              fixedSize: Size(300.sp, 50.sp),
            ),
            onPressed: onPressed,
            child: Text(
              "Log Out",
              style: TextStyle(
                fontSize: 19.sp,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
          const Spacer(),
        ],
      ),
    ),
  );
}
