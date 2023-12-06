import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sandiq/presentation/screens/store_keeper_screens/home_screen_store_keeper/components/product_add_button.dart';

import '../components/animation_builder_incoming_product_screen.dart';

class OutGoingProductScreenContent extends StatefulWidget {
  const OutGoingProductScreenContent({Key? key}) : super(key: key);

  @override
  State<OutGoingProductScreenContent> createState() =>
      _OutGoingProductScreenContentState();
}

class _OutGoingProductScreenContentState
    extends State<OutGoingProductScreenContent>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  bool _toggleTextFields = false;
  bool isButtonTapped = false;
  bool isSaved = false;

  TextEditingController textEditingNameController = TextEditingController();
  TextEditingController textEditingPhoneController = TextEditingController();
  TextEditingController textEditingProductController = TextEditingController();
  TextEditingController textEditingProductAmountController =
      TextEditingController();

  List<Widget> savedProductsWidgets = [];
  late Widget productWidget;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
      animationBehavior: AnimationBehavior.normal,
    );

    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleVisibility() {
    _toggleTextFields = !_toggleTextFields;
    if (_toggleTextFields) {
      _animationController.forward();
    } else {
      _animationController.repeat();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        primary: true,
        children: [
          Text(
            'Ombordan chiqayotgan maxsulotlar',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 20.sp,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: _toggleTextFields ? 5 : 30.sp),
          _toggleTextFields
              ? MyAnimationBuilder(
                  animationController: _animationController,
                  toggleTextFields: _toggleTextFields,
                  animation: _animation,
                  textEditingNameController: textEditingNameController,
                  textEditingPhoneController: textEditingPhoneController,
                  textEditingProductController: textEditingProductController,
                  textEditingProductAmountController:
                      textEditingProductAmountController,
                )
              : Column(
                  children: [
                    Image(
                      image: const AssetImage(
                        "assets/images/img_empty_box.png",
                      ),
                      height: 120.sp,
                      width: 120.sp,
                    ),
                    SizedBox(height: 20.sp),
                    Text(
                      "Qo'shilgan maxsulotlar shu yerda ko'rinadi",
                      style: TextStyle(
                        fontWeight: FontWeight.w200,
                        fontSize: 16.sp,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
          SizedBox(height: _toggleTextFields ? 5 : 30.sp),
          MyProductAddButton(
            onPressed: () {
              // if (_isTextFieldFilled()) {
              //   productWidget = ProductExpansionTile(
              //     textEditingProductController: textEditingProductController,
              //     textEditingProductAmountController:
              //         textEditingProductAmountController,
              //     textEditingNameController: textEditingNameController,
              //     textEditingPhoneController: textEditingPhoneController,
              //   );
              //
              //   savedProductsWidgets.add(productWidget);
              //   isSaved = !isSaved;
              // }

              _toggleVisibility();
              isButtonTapped = !isButtonTapped;
              setState(() {});

              // if (isSaved == false) {
              textEditingNameController.clear();
              textEditingPhoneController.clear();
              textEditingProductController.clear();
              textEditingProductAmountController.clear();
              // } else {
              //   return;
              // }
            },
            buttonText: isButtonTapped ? "Saqlash" : "Maxsulot qo'shish +",
          ),
          SizedBox(height: 60.sp),
        ],
      ),
    );
  }
}
