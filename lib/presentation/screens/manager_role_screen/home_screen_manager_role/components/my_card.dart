import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyCard extends StatelessWidget {
  final String product;
  final String price;
  final String volume;
  final String totalPrice;

  const MyCard({
    super.key,
    required this.price,
    required this.product,
    required this.totalPrice,
    required this.volume,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      margin: const EdgeInsets.only(top: 10),
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFF7F7F7),
        borderRadius: BorderRadius.circular(12),
      ),
      child: RichText(
        text: TextSpan(
          style: TextStyle(
            height: 1.5,
            color: Colors.black87,
            fontWeight: FontWeight.w600,
            fontSize: 17.5.sp,
          ),
          children: [
            const TextSpan(text: 'Mahsulot nomi: '),
            TextSpan(
              text: product,
              style: const TextStyle(
                fontWeight: FontWeight.w400,
              ),
            ),
            const TextSpan(text: '\n1 kg: '),
            TextSpan(
              text: price,
              style: const TextStyle(
                fontWeight: FontWeight.w400,
              ),
            ),
            const TextSpan(text: '\nBino uchun kerak: '),
            TextSpan(
              text: volume,
              style: const TextStyle(
                fontWeight: FontWeight.w400,
              ),
            ),
            const TextSpan(text: '\nJami narx: '),
            TextSpan(
              text: totalPrice,
              style: const TextStyle(
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
