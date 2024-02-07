import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sandiq/domain/model/user_model.dart';
import 'package:sandiq/presentation/screens/manager_role_screen/main_home_screen_manager_role.dart';
import 'package:sandiq/presentation/screens/registration_screen/login_page/login_page.dart';
import 'package:sandiq/presentation/screens/registration_screen/splash_screen/splash_screen.dart';
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
  late Future<User> user;
  UserService userService = UserService();

  @override
  void initState() {
    user = userService.fetchUserData();
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

  Widget determineHomePage(User user) {
    if (userLoggedIn) {
      switch (user.role) {
        case 's_admin':
          return const MainHomeScreenStoreKeeper();
        case 'Prorap':
          return const MainHomeScreenManagerRole();
        default:
          return const Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: Text('Foydalanuvchi topilmadi!'),
            ),
          );
      }
    } else {
      return const LoginScreen();
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
        home: FutureBuilder(
          future: userService.fetchUserData(),
          builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SplashScreen();
            } else {
              if (snapshot.hasError) {
                return const LoginScreen();
              } else {
                final User user = snapshot.data!;
                return determineHomePage(user);
              }
            }
          },
        ),
      ),
    );
  }
}
