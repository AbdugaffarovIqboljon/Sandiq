import 'package:flutter/material.dart';
import 'package:sandiq/presentation/screens/manager_role_screen/home_screen_manager_role/components/my_card.dart';
import 'package:sandiq/services/constants/colors.dart';


class HomeScreenManagerRole extends StatefulWidget {
  const HomeScreenManagerRole({super.key});

  @override
  State<HomeScreenManagerRole> createState() => _HomeScreenManagerRoleState();
}

class _HomeScreenManagerRoleState extends State<HomeScreenManagerRole> {

  List products = [
    MyCard(
      product: 'Mix',
      price: '5.000 so\'m',
      volume: '500 kg',
      totalPrice: '2.500.000 so\'m',
    ),
    MyCard(
      product: 'Siment',
      price: '2.000 so\'m',
      volume: '3000 kg',
      totalPrice: '6.000.000 so\'m',
    ),
    MyCard(
      product: 'Yog\'och',
      price: '24.000 so\'m',
      volume: '5000 metr',
      totalPrice: '120.000.000 so\'m',
    ),
    MyCard(
      product: 'Armatura',
      price: '7.200 so\'m',
      volume: '1000 metr',
      totalPrice: '7.200.000 so\'m',
    ),
    MyCard(
      product: 'Armatura',
      price: '7.200 so\'m',
      volume: '1000 metr',
      totalPrice: '7.200.000 so\'m',
    ),
    MyCard(
      product: 'Armatura',
      price: '7.200 so\'m',
      volume: '1000 metr',
      totalPrice: '7.200.000 so\'m',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.kWhite,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 36),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Xomashyolar',
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
      ),
    );
  }
}
