import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sandiq/presentation/screens/registration_screen/intro_screen/intro_screen.dart';
import 'package:sandiq/presentation/screens/store_keeper_screens/main_home_screen.dart';
import 'package:sandiq/services/user_service/token_manager.dart';
import 'package:sqflite/sqflite.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool userLoggedIn = false;

  @override
  void initState() {
    super.initState();
    checkIfUserLoggedIn();
  }

  Future<void> checkIfUserLoggedIn() async {
    try {
      final Database db = await TokenManager.initTokenDatabase();
      List<Map<String, dynamic>> token = await db.query('token');
      setState(() {
        userLoggedIn = token.isNotEmpty;
      });
    } catch (e) {
      print('Error occurred while checking user login: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      designSize: const Size(430, 932),
      child: MaterialApp(
        theme: ThemeData.light(useMaterial3: true),
        themeMode: ThemeMode.light,
        debugShowCheckedModeBanner: false,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        home: userLoggedIn
            ? const MainHomeScreenStoreKeeper()
            : const IntroScreen(),
      ),
    );
  }
}
