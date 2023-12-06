import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future buildShowDialogDeleteAccount(BuildContext context, String name) {
  return showAdaptiveDialog(
    barrierDismissible: true,
    context: context,
    useSafeArea: true,
    builder: (context) {
      return AlertDialog(
        clipBehavior: Clip.antiAlias,
        buttonPadding: EdgeInsets.symmetric(
          horizontal: 40.sp,
        ),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 10,
              shadowColor: const Color(0xFF00827B),
              fixedSize: Size(90.sp, 15.sp),
              backgroundColor: const Color(0xFF00827B),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              "Yo'q",
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 10,
              shadowColor: const Color(0xFF00827B),
              fixedSize: Size(90.sp, 15.sp),
              backgroundColor: const Color(0xFF00827B),
            ),
            onPressed: () {
              Navigator.pop(context);
              showAdaptiveDialog(
                barrierDismissible: true,
                context: context,
                builder: (context) {
                  return AlertDialog(
                    actionsPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 20,
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6.0),
                          child: Text(
                            name,
                            style: TextStyle(
                              fontSize: 19.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          decoration: InputDecoration(
                            isDense: true,
                            hintText: "Parolingizni kiriting",
                            hintStyle: TextStyle(
                              fontSize: 17.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(18),
                              ),
                            ),
                            enabled: true,
                            enabledBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(18),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    actions: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 10,
                          shadowColor: const Color(0xFF00827B),
                          backgroundColor: const Color(0xFF00827B),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Bekor Qilish",
                          style: TextStyle(
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 10,
                          shadowColor: const Color(0xFF00827B),
                          backgroundColor: const Color(0xFF00827B),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Tasdiqlash",
                          style: TextStyle(
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
            child: Text(
              "Ha",
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
        ],
        title: Column(
          children: [
            Image(
              image: const AssetImage("assets/icons/logout.png"),
              height: 80.sp,
              width: 80.sp,
            ),
            SizedBox(height: 50.sp),
            Text(
              "Haqiqatdan ham tizimdan chiqishni xohlaysizmi?",
              textAlign: TextAlign.center,
              // softWrap: true,
              style: TextStyle(
                fontSize: 21.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 20.sp),
          ],
        ),
      );
    },
  );
}
