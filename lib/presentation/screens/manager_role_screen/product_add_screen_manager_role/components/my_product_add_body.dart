import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sandiq/services/constants/colors.dart';

class MyProductAddBody extends StatelessWidget {
  final void Function()? onPressed;

  const MyProductAddBody({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 50),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Buyurtma qilish',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 18,
                ),
              ),
              InkWell(
                onTap: onPressed,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: CustomColors.kPrimaryColor,
                  ),
                  alignment: Alignment.center,
                  width: 160,
                  height: 50,
                  child: Text(
                    'Maxsulot qo\'shish +',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: CustomColors.kWhite,
                    ),
                    maxLines: 1,
                  ),
                ),
              ),
            ],
          ),
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(top: 20),
            width: double.infinity,
            height: MediaQuery.of(context).size.height / 2,
            decoration: const BoxDecoration(color: Colors.white),
            child: Image.asset(
              'assets/images/img_empty_box.png',
              height: 120.sp,
              width: 120.sp,

            ),
          ),
        ],
      ),
    );
  }
}
