import 'package:flutter/material.dart';

import 'history_card.dart';

class MyBodyListTile extends StatelessWidget {
  MyBodyListTile({super.key});

  final List products = [
    HistoryCard(id: 133, date: '12.11.2023'),
    HistoryCard(id: 132, date: '10.11.2023'),
    HistoryCard(id: 131, date: '8.11.2023'),
    HistoryCard(id: 130, date: '6.11.2023'),
    HistoryCard(id: 129, date: '4.11.2023'),
    HistoryCard(id: 128, date: '2.11.2023'),
    HistoryCard(id: 127, date: '1.11.2023'),
    HistoryCard(id: 126, date: '20.10.2023'),
    HistoryCard(id: 125, date: '18.10.2023'),
    HistoryCard(id: 124, date: '17.10.2023'),
    HistoryCard(id: 123, date: '15.10.2023'),
    HistoryCard(id: 122, date: '13.10.2023'),
    HistoryCard(id: 121, date: '11.10.2023'),
    HistoryCard(id: 120, date: '9.10.2023'),
    HistoryCard(id: 119, date: '7.10.2023'),
    HistoryCard(id: 118, date: '5.10.2023'),
    HistoryCard(id: 117, date: '3.10.2023'),
    HistoryCard(id: 116, date: '1.10.2023'),
    HistoryCard(id: 115, date: '29.9.2023'),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 36),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Buyurtmalar tarixi',
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height / 1.8,
            color: Colors.transparent,
            child: ListView.builder(
              itemBuilder: (context, index) {
                return products[index];
              },
              itemCount: products.length,
            ),
          ),
        ],
      ),
    );
  }
}
