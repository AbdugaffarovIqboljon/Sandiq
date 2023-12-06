import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sandiq/services/constants/colors.dart';


class ManageScreenStoreKeeper extends StatefulWidget {
  const ManageScreenStoreKeeper({super.key});

  @override
  State<ManageScreenStoreKeeper> createState() =>
      _ManageScreenStoreKeeperState();
}

class _ManageScreenStoreKeeperState extends State<ManageScreenStoreKeeper> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.kWhite,
      body: Column(
        children: [
          SizedBox(height: 100),
          Center(
            child: Text(
              "Manage Screen Coming Soon!",
              style: TextStyle(
                fontSize: 21.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

