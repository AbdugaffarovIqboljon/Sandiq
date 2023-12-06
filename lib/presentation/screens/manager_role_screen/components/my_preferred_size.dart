import 'package:flutter/material.dart';
import 'package:sandiq/services/constants/colors.dart';

class MyPreferredSize extends StatelessWidget {
  const MyPreferredSize({super.key});

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: const Offset(0, 30),
      child: Container(
        alignment: Alignment.center,
        width: 180,
        height: 60,
        decoration: BoxDecoration(
          color: CustomColors.kWhite,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 1,
              spreadRadius: 1,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/icons/ic_warehouse.png',
              height: 40,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              '1-Object',
              style: TextStyle(
                color: CustomColors.kPrimaryColor,
                fontSize: 26,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
