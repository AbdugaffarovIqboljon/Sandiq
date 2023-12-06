import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sandiq/presentation/screens/registration_screen/intro_screen/intro_screen.dart';
import 'package:sandiq/services/user_service/token_manager.dart';

import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  await TokenManager.initTokenDatabase();

  runApp(
    EasyLocalization(
      saveLocale: true,
      supportedLocales: const [
        Locale('uz', 'UZ'),
        Locale('ru', 'RU'),
      ],
      path: "assets/languages",
      fallbackLocale: const Locale('uz', 'UZ'),
      child: const IntroScreen(),
    ),
  );
}
