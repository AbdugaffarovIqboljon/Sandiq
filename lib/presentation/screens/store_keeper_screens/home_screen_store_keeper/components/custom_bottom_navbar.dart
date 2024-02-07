import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sandiq/services/constants/colors.dart';

class BottomNavBar extends StatelessWidget {
  final TabController controller;

  const BottomNavBar({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 40, top: 15),
      decoration: BoxDecoration(
        color: CustomColors.kWhite,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(35),
          topRight: Radius.circular(35),
        ),
        border: Border.all(
          width: 0.5,
          color: Colors.grey.shade300,
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            offset: const Offset(0, 1),
            spreadRadius: 1,
            color: Colors.grey.shade300,
          ),
        ],
      ),
      child: TabBar(
        indicatorColor: CustomColors.kPrimaryColor,
        labelColor: CustomColors.kPrimaryColor,
        unselectedLabelColor: Colors.grey.shade500,
        dividerColor: CustomColors.kTransparent,
        controller: controller,
        tabs: [
          Tab(
            icon: Column(
              children: [
                Icon(CupertinoIcons.home, size: 22.sp),
                const SizedBox(height: 2),
                const Text("Home"),
              ],
            ),
          ),
          Tab(
            icon: Column(
              children: [
                Icon(CupertinoIcons.shopping_cart, size: 22.sp),
                const SizedBox(height: 2),
                const Text("Cart"),
              ],
            ),
          ),
          Tab(
            icon: Column(
              children: [
                Icon(Icons.history, size: 23.sp),
                const SizedBox(height: 2),
                const Text("History"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}