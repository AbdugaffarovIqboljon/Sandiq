import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
        clipBehavior: Clip.antiAlias,
        buttonPadding: EdgeInsets.symmetric(
          horizontal: 40.sp,
        ),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 10,
              shadowColor: const Color(0xFF00827B),
              fixedSize: Size(90.sp, 15.sp),
              backgroundColor: const Color(0xFF00827B),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              "Yo'q",
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 10,
              shadowColor: const Color(0xFF00827B),
              fixedSize: Size(90.sp, 15.sp),
              backgroundColor: const Color(0xFF00827B),
            ),
            onPressed: () async {
              ///# Password input
              // showAdaptiveDialog(
              //   barrierDismissible: true,
              //   context: context,
              //   builder: (context) {
              //     return AlertDialog(
              //       actionsPadding: const EdgeInsets.symmetric(
              //         horizontal: 20,
              //         vertical: 20,
              //       ),
              //       title: Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           Padding(
              //             padding: const EdgeInsets.symmetric(horizontal: 6.0),
              //             child: Text(
              //               name,
              //               style: TextStyle(
              //                 fontSize: 19.sp,
              //                 fontWeight: FontWeight.w500,
              //                 color: Colors.black,
              //               ),
              //             ),
              //           ),
              //           const SizedBox(height: 20),
              //           TextField(
              //             decoration: InputDecoration(
              //               isDense: true,
              //               hintText: "Parolingizni kiriting",
              //               hintStyle: TextStyle(
              //                 fontSize: 17.sp,
              //                 fontWeight: FontWeight.w500,
              //                 color: Colors.black,
              //               ),
              //               border: const OutlineInputBorder(
              //                 borderRadius: BorderRadius.all(
              //                   Radius.circular(18),
              //                 ),
              //               ),
              //               enabled: true,
              //               enabledBorder: const OutlineInputBorder(
              //                 borderRadius: BorderRadius.all(
              //                   Radius.circular(18),
              //                 ),
              //               ),
              //             ),
              //           ),
              //         ],
              //       ),
              //       actions: [
              //         ElevatedButton(
              //           style: ElevatedButton.styleFrom(
              //             elevation: 10,
              //             shadowColor: const Color(0xFF00827B),
              //             backgroundColor: const Color(0xFF00827B),
              //           ),
              //           onPressed: () {
              //             Navigator.pop(context);
              //           },
              //           child: Text(
              //             "Bekor Qilish",
              //             style: TextStyle(
              //               fontSize: 17.sp,
              //               fontWeight: FontWeight.w500,
              //               color: Colors.white,
              //             ),
              //           ),
              //         ),
              //         ElevatedButton(
              //           style: ElevatedButton.styleFrom(
              //             elevation: 10,
              //             shadowColor: const Color(0xFF00827B),
              //             backgroundColor: const Color(0xFF00827B),
              //           ),
              //           onPressed: () {
              //             Navigator.pop(context);
              //           },
              //           child: Text(
              //             "Tasdiqlash",
              //             style: TextStyle(
              //               fontSize: 17.sp,
              //               fontWeight: FontWeight.w500,
              //               color: Colors.white,
              //             ),
              //           ),
              //         ),
              //       ],
              //     );
              //   },
              // );

              await logout(context, navigateToIntroScreen);
            },
            child: Text(
              "Ha",
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
        ],
        title: Column(
          children: [
            Image(
              image: const AssetImage("assets/icons/logout.png"),
              height: 80.sp,
              width: 80.sp,
            ),
            SizedBox(height: 50.sp),
            Text(
              "Haqiqatdan ham tizimdan chiqishni xohlaysizmi?",
              textAlign: TextAlign.center,
              // softWrap: true,
              style: TextStyle(
                fontSize: 21.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 20.sp),
          ],
        ),
      );
    },
  );
}

Future<void> logout(
    BuildContext context, void Function() navigateToIntroScreen) async {
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

// Future<void> logout(
//     BuildContext context, void Function() navigateToIntroScreen) async {
//   final Dio dio = Dio();
//
//   showDialog(
//     context: context,
//     barrierDismissible: false,
//     builder: (BuildContext context) {
//       return const Dialog(
//         child: Padding(
//           padding: EdgeInsets.all(20.0),
//           child: Row(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               CircularProgressIndicator.adaptive(),
//               SizedBox(width: 20.0),
//               Text('Logging out...'),
//             ],
//           ),
//         ),
//       );
//     },
//   );
//
//   try {
//     final response = await dio.post(
//       'https://e-work-backend-production.up.railway.app/api/logout/',
//       options: Options(
//         headers: {
//           'accept': 'application/json',
//         },
//       ),
//     );
//
//     if (response.statusCode == 200 || response.statusCode == 201) {
//       await TokenManager.removeToken();
//       print('User logged out successfully.');
//       Navigator.of(context).pop();
//       navigateToIntroScreen();
//     } else {
//       // Handle other status codes or errors
//       print('Failed to logout. Status Code: ${response.statusCode}');
//       Navigator.of(context).pop(); // Dismiss the loading indicator
//     }
//   } catch (error) {
//     // Handle Dio errors
//     print('Error occurred during logout: $error');
//     Navigator.of(context).pop(); // Dismiss the loading indicator
//   }
// }
