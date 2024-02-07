import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:sandiq/presentation/screens/registration_screen/intro_screen/intro_screen.dart';
import 'package:sandiq/services/user_service/token_manager.dart';

Future buildShowDialogDeleteAccount(BuildContext context, String name) {
  void navigateToIntroScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const IntroScreen()),
    );
  }

  return showAdaptiveDialog(
    barrierDismissible: true,
    context: context,
    useSafeArea: true,
    builder: (context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        clipBehavior: Clip.antiAlias,
        title: Column(
          children: [
            Lottie.asset("assets/lottie/animation_log_out.json", width: 180, height: 180),
            SizedBox(height: 30.sp),
            Text(
              "Tizimdan chiqishni xohlaysizmi?",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 30.sp),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                elevatedButtonAlertDialog(
                  context: context,
                  onPressed: () => Navigator.pop(context),
                  text: "Yo'q",
                ),
                elevatedButtonAlertDialog(
                  context: context,
                  onPressed: () async {
                    await logout(context, navigateToIntroScreen);
                  },
                  text: "Ha",
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}

ElevatedButton elevatedButtonAlertDialog({
  required BuildContext context,
  required void Function() onPressed,
  required String text,
}) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      elevation: 10,
      shadowColor: const Color(0xFF00827B),
      fixedSize: Size(90.sp, 15.sp),
      backgroundColor: const Color(0xFF00827B),
    ),
    onPressed: onPressed,
    child: Text(
      text,
      style: TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
    ),
  );
}

Future<void> logout(
  BuildContext context,
  void Function() navigateToIntroScreen,
) async {
  final Dio dio = Dio();

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return const Dialog(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator.adaptive(),
              SizedBox(height: 20.0),
              Text('Logging out...'),
            ],
          ),
        ),
      );
    },
  );

  try {
    final String? savedToken = await TokenManager.getToken();
    final options = Options(
      headers: {
        'accept': 'application/json',
        'Bearer': savedToken,
      },
    );

    final response = await dio.post(
      'https://e-work-backend-production.up.railway.app/api/logout/',
      options: options,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      await TokenManager.removeToken();
      print('User logged out successfully.');
      navigateToIntroScreen();
      print("RESPONSE DATA ==========${response.data}=============");
    } else {
      print('Failed to logout. Status Code: ${response.statusCode}');
      Navigator.of(context).pop();
    }
  } catch (e) {
    print('Error occurred during logout: $e');
    Navigator.of(context).pop();
  }
}
