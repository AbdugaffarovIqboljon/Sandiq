import 'package:flutter/material.dart';

// ignore: must_be_immutable
class HistoryCard extends StatelessWidget {
  int id;
  String date;

  HistoryCard({
    super.key,
    required this.id,
    required this.date,
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
      child: Row(
        children: [
          Text(
            'Buyurtma raqami: $id',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade800,
              fontWeight: FontWeight.w500,
              letterSpacing: .5,
            ),
          ),
          const Spacer(),
          Text(
            date,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              letterSpacing: .5,
            ),
          ),
          const SizedBox(width: 10),
          const Icon(Icons.abc),
        ],
      ),
    );
  }
}
