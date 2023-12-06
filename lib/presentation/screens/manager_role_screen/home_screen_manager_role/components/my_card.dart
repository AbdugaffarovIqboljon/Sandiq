import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyCard extends StatelessWidget {
  String product;
  String price;
  String volume;
  String totalPrice;

  MyCard({
    super.key,
    required this.price,
    required this.product,
    required this.totalPrice,
    required this.volume,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      margin: const EdgeInsets.only(top: 10),
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFF7F7F7),
        borderRadius: BorderRadius.circular(12),
      ),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
          children: [
            const TextSpan(text: 'Mahsulot nomi: '),
            TextSpan(
              text: product,
              style: const TextStyle(
                fontWeight: FontWeight.w400,
              ),
            ),
            const TextSpan(text: '\n1kg: '),
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
