import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../components/custom_elevated_button.dart';
import '../login_page/login_page.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  bool uzTapped = true;
  bool ruTapped = false;

  void navigateToLoginScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(flex: 2),

            /// #Header Logo
            Image.asset(
              'assets/images/img_sandiq_logo.png',
              width: 200.sp,
            ),
            const Spacer(flex: 2),

            /// #Header Image
            Image.asset(
              'assets/images/img_entry_page_header.png',
              width: 300.sp,
            ),
            const Spacer(),

            /// #Welcome Message
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                "intro_welcome_message".tr(),
                textAlign: TextAlign.center,
                maxLines: 2,
                style: TextStyle(
                  fontSize: 35.sp,
                ),
              ),
            ),

            const Spacer(flex: 2),

            /// #ElevatedButton
            CustomElevatedButton(
              displayText: "button_enter".tr(),
              onPressed: navigateToLoginScreen,
            ),
            const Spacer(),

            /// #Sub TextButtons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Spacer(),
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: uzTapped == true
                        ? const Color(0xFF00827B)
                        : const Color(0xFFC4BECD),
                  ),
                  onPressed: () {
                    uzTapped = !uzTapped;
                    if (uzTapped) {
                      ruTapped = false;
                      setState(() {});
                    }
                    context.setLocale(
                      const Locale('uz', 'UZ'),
                    );
                  },
                  child: Text(
                    'text_button_uzb'.tr(),
                  ),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: ruTapped == true
                        ? const Color(0xFF00827B)
                        : const Color(0xFFC4BECD),
                  ),
                  onPressed: () {
                    ruTapped = !ruTapped;
                    if (ruTapped) {
                      uzTapped = false;
                      setState(() {});
                    }
                    context.setLocale(
                      const Locale('ru', 'RU'),
                    );
                  },
                  child: Text(
                    'text_button_rus'.tr(),
                  ),
                ),
                const Spacer(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
