import 'package:flutter/material.dart';
import 'package:sandiq/presentation/screens/store_keeper_screens/home_screen_store_keeper/components/product_add_textfield.dart';

class MyAnimationBuilder extends StatelessWidget {
  const MyAnimationBuilder({
    super.key,
    required AnimationController animationController,
    required bool toggleTextFields,
    required Animation<double> animation,
    required this.textEditingNameController,
    required this.textEditingPhoneController,
    required this.textEditingProductController,
    required this.textEditingProductAmountController,
  })  : _animationController = animationController,
        _toggleTextFields = toggleTextFields,
        _animation = animation;

  final AnimationController _animationController;
  final bool _toggleTextFields;
  final Animation<double> _animation;
  final TextEditingController textEditingNameController;
  final TextEditingController textEditingPhoneController;
  final TextEditingController textEditingProductController;
  final TextEditingController textEditingProductAmountController;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        final curvedAnimation = CurvedAnimation(
          parent: _animationController,
          curve: Curves.easeOutBack,
        );
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0.0, -1.0),
            end: Offset.zero,
          ).animate(curvedAnimation),
          child: Visibility(
            visible: _toggleTextFields,
            child: Opacity(
              opacity: _animation.value,
              child: Transform.scale(
                scale: _animation.value,
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    ProductAddTextField(
                      hinText: "Ismi",
                      textEditingController: textEditingNameController,
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(height: 20),
                    ProductAddTextField(
                      hinText: "Telefon Raqami",
                      textEditingController: textEditingPhoneController,
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(height: 20),
                    ProductAddTextField(
                      hinText: "Maxsulot Turi",
                      textEditingController: textEditingProductController,
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(height: 20),
                    ProductAddTextField(
                      hinText: "Maxsulot Miqdori",
                      textEditingController: textEditingProductAmountController,
                      textInputAction: TextInputAction.done,
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
