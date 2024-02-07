import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../components/custom_elevated_button.dart';
import '../login_page/login_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(flex: 2),

          /// #Header Logo
          Image.asset(
            'assets/images/img_sandiq_logo.png',
            width: 200.sp,
          ),
          const Spacer(),

          /// #Header Image
          Image.asset(
            'assets/images/img_entry_page_header.png',
            width: 280.sp,
          ),
          const Spacer(),

          /// #Welcome Message
          Center(
            child: Text(
              "intro_welcome_message".tr(),
              textAlign: TextAlign.center,
              maxLines: 2,
              style: TextStyle(
                fontSize: 30.sp,
              ),
            ),
          ),

          const Spacer(flex: 3),
        ],
      ),
    );
  }
}
