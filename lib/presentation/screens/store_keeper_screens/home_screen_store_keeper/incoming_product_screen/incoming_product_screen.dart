import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sandiq/domain/model/product_delivery.dart';
import 'package:sandiq/domain/model/product_model.dart';
import 'package:sandiq/presentation/screens/store_keeper_screens/home_screen_store_keeper/components/product_add_button.dart';

import '../components/animation_builder_incoming_product_screen.dart';
import '../components/empty_product_case.dart';
import '../components/incoming_products_content.dart';

int selectedProductId = 0;

class IncomingProductScreenContent extends StatefulWidget {
  const IncomingProductScreenContent({Key? key}) : super(key: key);

  @override
  State<IncomingProductScreenContent> createState() =>
      _IncomingProductScreenContentState();
}

class _IncomingProductScreenContentState
    extends State<IncomingProductScreenContent> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  bool _toggleTextFields = false;
  bool isButtonTapped = false;
  late List<bool> isListTileTappedList;

  TextEditingController textEditingNameController = TextEditingController();
  TextEditingController textEditingPhoneController = TextEditingController();
  TextEditingController textEditingProductController = TextEditingController();
  TextEditingController textEditingProductAmountController =
      TextEditingController();
  List<DeliveredProduct> productList = [];
  final ProductService productService = ProductService();

  Future<void> fetchIncomingProducts() async {
    try {
      List<DeliveredProduct> incomingProducts =
          await productService.fetchIncomingProducts();
      setState(() {
        productList = incomingProducts;
        isListTileTappedList =
            List.generate(productList.length, (index) => false);
      });
    } catch (e) {
      print('Error fetching incoming products: $e');
    }
  }

  Future<void> postData() async {
    try {
      await productService.postIncomingProduct(
        productId: selectedProductId,
        amount: int.tryParse(textEditingProductAmountController.text) ?? 1,
        description: "Incoming Product =>",
        deliveryName: textEditingNameController.text,
        deliveryPhone: "+998${textEditingPhoneController.text}",
        status: true,
      );
      fetchIncomingProducts();
    } catch (e, l) {
      print('Error fetching data: $e');
      print('Location of fetching data: $l');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchIncomingProducts();

    isListTileTappedList = List.generate(productList.length, (index) => false);

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
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
      _animationController.reverse();
    }
  }


  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        primary: true,
        children: [
          Text(
            'Omborga kirayotgan maxsulotlar',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 20.sp,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: _toggleTextFields ? 5 : 20.sp),
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
                  productService: productService,
                )
              : productList.isNotEmpty
                  ? IncomingProductsContent(productList: productList)
                  : buildEmptyProductCase(),
          SizedBox(height: _toggleTextFields ? 5 : 30.sp),
          MyProductAddButton(
            onPressed: () async {
              _toggleVisibility();
              postData();
              isButtonTapped = !isButtonTapped;

              textEditingProductController.clear();
              textEditingProductAmountController.clear();
              textEditingNameController.clear();
              textEditingPhoneController.clear();

              setState(() {});
            },
            buttonText: isButtonTapped ? "Saqlash" : "Maxsulot qo'shish +",
          ),
          SizedBox(height: 60.sp),
        ],
      ),
    );
  }
}
