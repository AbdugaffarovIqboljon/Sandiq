import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ButtonAnimation extends StatefulWidget {
  final ValueNotifier<int> selectedIconIndex;

  const ButtonAnimation({Key? key, required this.selectedIconIndex})
      : super(key: key);

  @override
  State<ButtonAnimation> createState() => _ButtonAnimationState();
}

class _ButtonAnimationState extends State<ButtonAnimation> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          children: [
            Align(
              alignment: Alignment(
                  widget.selectedIconIndex.value == 1 ? 0.97 : -0.97, 0,
              ),
              child: Container(
                width: 180.sp,
                height: 60.sp,
                decoration: BoxDecoration(
                  color: const Color(0xFF00827B),
                  borderRadius: BorderRadius.all(
                    Radius.circular(30.sp),
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.tealAccent,
                      offset: Offset(0, 1),
                      spreadRadius: 1,
                      blurRadius: 5,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5.sp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      widget.selectedIconIndex.value = 0;
                      setState(() {});
                    },
                    child: Image(
                      image: const AssetImage(
                        "assets/images/img_incoming_parcel.png",
                      ),
                      height: 34.sp,
                      width: 34.sp,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      widget.selectedIconIndex.value = 1;
                      setState(() {});
                    },
                    child: Image(
                      image: const AssetImage(
                        "assets/images/img_delivery_truck.png",
                      ),
                      height: 45.sp,
                      width: 45.sp,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
