import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sandiq/presentation/screens/store_keeper_screens/home_screen_store_keeper/components/button_animation.dart';
import 'package:sandiq/services/constants/colors.dart';

import 'incoming_product_screen/incoming_product_screen.dart';
import 'outgoing_product_screen/outgoing_product_screen.dart';

class HomeScreenStoreKeeper extends StatefulWidget {
  const HomeScreenStoreKeeper({Key? key}) : super(key: key);

  @override
  State<HomeScreenStoreKeeper> createState() => _HomeScreenStoreKeeperState();
}

class _HomeScreenStoreKeeperState extends State<HomeScreenStoreKeeper> {
  final ValueNotifier<int> selectedIconIndex = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.kWhite,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            SizedBox(height: 60.sp),
            Container(
              padding: EdgeInsets.only(left: 3.sp, right: 3.sp),
              width: double.infinity,
              height: 70.sp,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(35.sp),
                ),
                color: const Color(0xFFD2D2D2),
              ),
              child: ButtonAnimation(
                selectedIconIndex: selectedIconIndex,
              ),
            ),
            const SizedBox(height: 20),
            ValueListenableBuilder<int>(
              valueListenable: selectedIconIndex,
              builder: (context, index, _) {
                return index == 0
                    ? const IncomingProductScreenContent()
                    : const OutGoingProductScreenContent();
              },
            ),
          ],
        ),
      ),
    );
  }
}
