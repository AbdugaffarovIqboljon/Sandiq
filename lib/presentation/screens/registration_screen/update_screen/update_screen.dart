import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sandiq/presentation/screens/registration_screen/login_page/login_page.dart';
import 'package:sandiq/presentation/screens/store_keeper_screens/main_home_screen.dart';
import 'package:sandiq/services/user_service/token_manager.dart';

import '../../manager_role_screen/home_screen_manager_role/home_screen_manager_role.dart';
import '../components/custom_elevated_button.dart';
import '../components/custom_textfield.dart';

class UpdateScreen extends StatefulWidget {
  const UpdateScreen({Key? key}) : super(key: key);

  static const route = '/update';

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  late TextEditingController userNameController;
  late TextEditingController fullNameController;
  late TextEditingController passwordController;
  late TextEditingController phoneController;
  final formKey = GlobalKey<FormState>();
  bool isObscured = true;

  late String savedToken;
  Map<String, dynamic> jsonData = {};

  @override
  void initState() {
    super.initState();
    fetchUserData();
    getToken();
    userNameController = TextEditingController();
    passwordController = TextEditingController();
    fullNameController = TextEditingController();
    phoneController = TextEditingController();
  }

  Future<void> getToken() async {
    final token =
        await TokenManager.getToken(); // Retrieve the token from TokenManager
    setState(() {
      savedToken = token ?? "null";
    });
  }

  Dio dio = Dio();

  void navigateToManagerHomeScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const HomeScreenManagerRole(),
      ),
    );
  }

  void navigateToMainHomeScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const MainHomeScreenStoreKeeper(),
      ),
    );
  }

  Future<void> updateUserInformation() async {
    Map<String, Object?> requestData = {
      "name": fullNameController.text,
      "phone": phoneController.text,
      "username": userNameController.text,
      "password": passwordController.text,
    };

    Options options = Options(
      headers: {
        'Authorization': 'Bearer $savedToken', // Use the saved token here
        'Content-Type': 'application/json',
        'accept': 'application/json',
      },
    );

    try {
      Response response = await dio.post(
        'https://e-work-backend-production.up.railway.app/auth/users/first/edit',
        options: options,
        data: requestData,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        setState(() {});
        navigateToLoginScreen();
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: const Color(0xFFC4BECD),
          content: Text(
            "iltimos, barcha maydonlarni toʻldiring",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 19.sp,
              color: Colors.black54,
            ),
            textAlign: TextAlign.center,
          ),
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
        ),
      );
      debugPrint('Error updating user information: $e');
    }
  }

  void navigateToLoginScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }

  Future<void> fetchUserData() async {
    Options options = Options(
      headers: {
        'Authorization': 'Bearer $savedToken',
      },
    );

    try {
      Response response = await dio.get(
        'https://e-work-backend-production.up.railway.app/auth/users/me',
        options: options,
      );
      setState(() {
        jsonData = response.data ?? {};
      });
    } catch (e) {
      debugPrint('Error fetching data: $e');
    }
  }

  RegExp phoneNumberRegex = RegExp(r'^\+998[0-9]{9}$');
  bool regexChecker(String text, RegExp regex) {
    return !regex.hasMatch(text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Center(
                  child: Image(
                    image: const AssetImage(
                      "assets/images/img_sandiq_logo.png",
                    ),
                    width: 250.sp,
                  ),
                ),
                const SizedBox(height: 30),
                Image(
                  image: const AssetImage("assets/images/img_login_header.png"),
                  width: 320.sp,
                ),
                const SizedBox(height: 30),

                /// #FullName Textfield
                CustomRegistrationTextField(
                  isObscured: false,
                  validator: (value) {
                    return null;
                  },
                  controller: fullNameController,
                  hinText: "${jsonData['name'] ?? ''}",
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
                const SizedBox(height: 15),

                /// #Phone Textfield
                CustomRegistrationTextField(
                  isObscured: false,
                  validator: (value) {
                    if (regexChecker(value!, phoneNumberRegex)) {
                      return 'Raqamingizni tekshiring';
                    }
                    return null;
                  },
                  controller: phoneController,
                  hinText: "${jsonData['phone'] ?? ''}",
                  prefixIcon: Icon(
                    Icons.phone,
                    color: const Color(0xFFA4A3A4),
                    size: 25.sp,
                  ),
                  textInputAction: TextInputAction.next,
                ),

                const SizedBox(height: 15),

                /// #Username Textfield
                CustomRegistrationTextField(
                  isObscured: false,
                  validator: (value) {
                    return null;
                  },
                  controller: userNameController,
                  hinText: jsonData["username"] ?? "",
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
                const SizedBox(height: 30),

                /// #Password TextField
                CustomRegistrationTextField(
                  isObscured: isObscured,
                  validator: (value) {
                    if (passwordController.text.isEmpty) {
                      return 'Parolni kiriting *';
                    }
                    return null;
                  },
                  controller: passwordController,
                  hinText: "password".tr(),
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

                const SizedBox(height: 30),

                /// #SubElevatedButton
                CustomElevatedButton(
                  displayText: "next".tr(),
                  onPressed: () {
                    fetchUserData();
                    if (jsonData.isNotEmpty) {
                      updateUserInformation();
                    } else {
                      debugPrint('jsonData is not available');
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
