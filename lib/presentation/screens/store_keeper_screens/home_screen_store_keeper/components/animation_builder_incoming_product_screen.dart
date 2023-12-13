import 'package:flutter/material.dart';
import 'package:sandiq/domain/model/product.dart';
import 'package:sandiq/presentation/screens/store_keeper_screens/home_screen_store_keeper/components/product_add_textfield.dart';

import '../incoming_product_screen/incoming_product_screen.dart';

class MyAnimationBuilder extends StatefulWidget {
  final AnimationController _animationController;
  final bool _toggleTextFields;
  final Animation<double> _animation;
  final TextEditingController textEditingNameController;
  final TextEditingController textEditingPhoneController;
  final TextEditingController textEditingProductController;
  final TextEditingController textEditingProductAmountController;
  final ProductService productService;

  const MyAnimationBuilder({
    super.key,
    required AnimationController animationController,
    required bool toggleTextFields,
    required Animation<double> animation,
    required this.textEditingNameController,
    required this.textEditingPhoneController,
    required this.textEditingProductController,
    required this.textEditingProductAmountController,
    required this.productService,
  })  : _animationController = animationController,
        _toggleTextFields = toggleTextFields,
        _animation = animation;

  @override
  State<MyAnimationBuilder> createState() => _MyAnimationBuilderState();
}

class _MyAnimationBuilderState extends State<MyAnimationBuilder> {
  Product? selectedProduct;

  void updateSelectedProduct(Product product) {
    setState(() {
      selectedProduct = product;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget._animationController,
      builder: (context, child) {
        final curvedAnimation = CurvedAnimation(
          parent: widget._animationController,
          curve: Curves.easeOutBack,
        );
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0.0, -1.0),
            end: Offset.zero,
          ).animate(curvedAnimation),
          child: Visibility(
            visible: widget._toggleTextFields,
            child: Opacity(
              opacity: widget._animation.value,
              child: Transform.scale(
                scale: widget._animation.value,
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    ProductAddTextField(
                      hinText: "Ismi",
                      textEditingController: widget.textEditingNameController,
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(height: 20),
                    ProductAddTextField(
                      hinText: "Telefon Raqami",
                      textEditingController: widget.textEditingPhoneController,
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(height: 20),
                    ProductTypeSelector(
                      productService: widget.productService,
                      textEditingController:
                          widget.textEditingProductController,
                      onSelected: updateSelectedProduct,
                    ),
                    const SizedBox(height: 20),
                    ProductAddTextField(
                      hinText: 'Miqdorni kiriting',
                      textEditingController:
                          widget.textEditingProductAmountController,
                      textInputAction: TextInputAction.done,
                      suffixText:
                          selectedProduct != null ? selectedProduct?.size : '',
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
