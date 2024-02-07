import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sandiq/presentation/screens/manager_role_screen/main_home_screen_manager_role.dart';
import 'package:sandiq/presentation/screens/registration_screen/components/custom_elevated_button.dart';
import 'package:sandiq/presentation/screens/registration_screen/components/custom_textfield.dart';
import 'package:sandiq/presentation/screens/registration_screen/update_screen/update_screen.dart';
import 'package:sandiq/presentation/screens/store_keeper_screens/main_home_screen.dart';
import 'package:sandiq/services/user_service/token_manager.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isObscured = true;

  void login() async {
    String username = usernameController.text;
    String password = passwordController.text;
    final dio = Dio();
    const url = 'https://e-work-backend-production.up.railway.app/auth/login';
    Response response;

    try {
      response = await dio.post(
        url,
        data: {
          'username': username,
          'password': password,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint(
          '========== SUCCESSFUL ==========\n${response.statusCode}',
        );

        final receivedData = response.data;
        final receivedToken = response.data["token"];
        await TokenManager.saveToken(receivedToken);

        debugPrint('RECEIVED TOKEN ======> $receivedToken');

        if (receivedData["status"] == false) {
          navigateToUpdateScreen();
        }
        if (receivedData["status"] == true &&
            receivedData["role"] == "s_admin") {
          print("Hello STORE KEEPER");
          navigateToMainHomeScreenStoreKeeper();
        }
        if (receivedData["status"] == true &&
            receivedData["role"] == "Prorap") {
          print("Hello MANAGER");
          navigateToManagerHomeScreen();
        }

        setState(() {});
      }
    } catch (e, l) {
      debugPrint('================= $e =================');
      debugPrint('LOCATION \n================= $l =================');
    }
  }

  void navigateToUpdateScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const UpdateScreen(),
      ),
    );
  }

  void navigateToManagerHomeScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const MainHomeScreenManagerRole(),
      ),
    );
  }

  void navigateToMainHomeScreenStoreKeeper() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const MainHomeScreenStoreKeeper(),
      ),
    );
  }

  RegExp nonEmptyRegex = RegExp(r'^(?!\s*$).+');

  bool regexChecker(String password, RegExp regExp) {
    return !regExp.hasMatch(password);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              const Spacer(flex: 4),

              /// #Logo
              Center(
                child: Image(
                  image: const AssetImage("assets/images/img_sandiq_logo.png"),
                  width: 250.sp,
                ),
              ),
              const Spacer(),

              /// #Header Image
              Image(
                image: const AssetImage("assets/images/img_login_header.png"),
                width: 320.sp,
              ),
              const Spacer(flex: 2),

              /// #First TextField
              CustomRegistrationTextField(
                isObscured: false,
                validator: (value) {
                  if (regexChecker(value ?? '', nonEmptyRegex)) {
                    return 'Usernameni kiriting';
                  }
                  return null;
                },
                controller: usernameController,
                hinText: "Username",
                prefixIcon: Image(
                  image: const AssetImage(
                    "assets/icons/ic_user_filled.png",
                  ),
                  color: const Color(0xFFA4A3A4),
                  width: 25.sp,
                  height: 25.sp,
                ),
                textInputAction: TextInputAction.next,
              ),
              const Spacer(flex: 1),

              /// #Second TextField
              CustomRegistrationTextField(
                isObscured: isObscured,
                validator: (String? value) {
                  if (passwordController.text.isEmpty) {
                    return 'Parolni kiriting';
                  }
                  return null;
                },
                controller: passwordController,
                hinText: "enter_password".tr(),
                prefixIcon: Image(
                  image: const AssetImage(
                    "assets/icons/ic_lock_disabled.png",
                  ),
                  width: 28.sp,
                  height: 28.sp,
                ),
                suffixIcon: IconButton(
                  onPressed: () {
                    isObscured = !isObscured;
                    setState(() {});
                  },
                  icon: Image(
                    image: isObscured
                        ? const AssetImage("assets/icons/ic_eye_off.png")
                        : const AssetImage("assets/icons/ic_eye.png"),
                    width: 28.sp,
                    height: 28.sp,
                  ),
                ),
                textInputAction: TextInputAction.done,
              ),
              const Spacer(flex: 3),

              /// #SubElevatedButton
              CustomElevatedButton(
                displayText: "next".tr(),
                onPressed: () {
                  login();
                },
              ),

              const Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }
}
