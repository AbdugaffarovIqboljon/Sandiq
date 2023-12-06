import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sandiq/domain/model/product.dart';
import 'package:sandiq/presentation/screens/registration_screen/login_page/login_page.dart';
import 'package:sandiq/presentation/screens/store_keeper_screens/home_screen_store_keeper/components/product_add_button.dart';

import '../components/animation_builder_incoming_product_screen.dart';

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
  bool isSaved = false;
  List<Widget> savedProductsList = [];
  List fetchedProductsList = [];
  Map<String, dynamic> result = {};
  Dio dio = Dio();

  TextEditingController textEditingNameController = TextEditingController();
  TextEditingController textEditingPhoneController = TextEditingController();
  TextEditingController textEditingProductController = TextEditingController();
  TextEditingController textEditingProductAmountController =
      TextEditingController();

  final String url =
      'https://e-work-backend-production.up.railway.app/products/list';

  List<Product> productList = [];

  // Future<void> fetchProductList() async {
  //   try {
  //     Response response = await dio.get(
  //       url,
  //       options: Options(headers: {
  //         'accept': 'application/json',
  //         'Authorization': 'Bearer $token', // Include the token here
  //       }),
  //     );
  //
  //     // Assuming the response is a list of Product objects
  //     List<dynamic> data = response.data;
  //     setState(() {
  //       productList = data.map((item) => Product.fromJson(item)).toList();
  //     });
  //   } catch (error) {
  //     print("Failed to fetch product list: $error");
  //   }
  // }

  @override
  void initState() {
    super.initState();
    // fetchProductList();

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

  bool _isTextFieldFilled() {
    return textEditingNameController.text.isNotEmpty &&
        textEditingPhoneController.text.isNotEmpty &&
        textEditingProductController.text.isNotEmpty &&
        textEditingProductAmountController.text.isNotEmpty;
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
              : productList.isNotEmpty
                  ? ListView.builder(
                      itemBuilder: (context, index) {
                        final fetchedProduct = productList[index];
                        return DropdownMenu(
                          dropdownMenuEntries: [
                            DropdownMenuEntry(value: Text(fetchedProduct.name), label: fetchedProduct.size)
                          ],
                        );
                      },
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
              if (_isTextFieldFilled()) {
                // saveToSqflite();
              }
              _toggleVisibility();
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

// class IncomingProductScreenContent extends StatefulWidget {
//   const IncomingProductScreenContent({Key? key}) : super(key: key);
//
//   @override
//   State<IncomingProductScreenContent> createState() =>
//       _IncomingProductScreenContentState();
// }
//
// class _IncomingProductScreenContentState
//     extends State<IncomingProductScreenContent> with TickerProviderStateMixin {
//   late AnimationController _animationController;
//   late Animation<double> _animation;
//   bool _toggleTextFields = false;
//   bool isButtonTapped = false;
//   bool isSaved = false;
//   List<Widget> savedProductsList = [];
//   List fetchedProductsList = [];
//   Map<String, dynamic> result = {};
//   Dio dio = Dio();
//
//   TextEditingController textEditingNameController = TextEditingController();
//   TextEditingController textEditingPhoneController = TextEditingController();
//   TextEditingController textEditingProductController = TextEditingController();
//   TextEditingController textEditingProductAmountController =
//       TextEditingController();
//
//
//
//   Future<void> _initializeSavedProducts() async {
//     DatabaseHelper dbHelper = DatabaseHelper();
//     List<Product> productList = await dbHelper.getProducts();
//
//     savedProductsList = productList.map((product) {
//       return _buildProductTile(product);
//     }).toList();
//
//     setState(() {});
//   }
//
//   Widget _buildProductTile(Product product) {
//     return InkWell(
//       borderRadius: const BorderRadius.all(
//         Radius.circular(20),
//       ),
//       onTap: () {
//         _removeProduct(product);
//         setState(() {});
//       },
//       child: Container(
//         height: 150,
//         width: double.infinity,
//         margin: const EdgeInsets.symmetric(vertical: 8),
//         padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
//         decoration: BoxDecoration(
//           color: Colors.blueGrey.shade100,
//           borderRadius: const BorderRadius.all(
//             Radius.circular(20),
//           ),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const SizedBox(height: 10),
//             Text("Maxsulot turi: ${product.productType}"),
//             const SizedBox(height: 10),
//             Text("Maxsulot qiymati: ${product.productAmount}"),
//             const SizedBox(height: 10),
//             Text("Ismi: ${product.name}"),
//             const SizedBox(height: 10),
//             Text("Telefon raqami: ${product.phoneNumber}"),
//             const SizedBox(height: 10),
//           ],
//         ),
//       ),
//     );
//   }
//
//   void _removeProduct(Product product) async {
//     DatabaseHelper dbHelper = DatabaseHelper();
//     await dbHelper.deleteProduct(product.id!);
//
//     savedProductsList.removeWhere(
//       (widget) => widget.key == Key('product_${product.id}'),
//     );
//
//     setState(() {});
//   }
//
//   void saveToSqflite() async {
//     DatabaseHelper dbHelper = DatabaseHelper();
//
//     String name = textEditingNameController.text;
//     String phone = textEditingPhoneController.text;
//     String productType = textEditingProductController.text;
//     double productAmount =
//         double.tryParse(textEditingProductAmountController.text)!;
//
//     Product newProduct = Product(
//       name: name,
//       phoneNumber: phone,
//       productType: productType,
//       productAmount: productAmount,
//     );
//
//     await dbHelper.insertProduct(newProduct);
//
//     savedProductsList.add(_buildProductTile(newProduct));
//
//     setState(() {});
//   }
//
//   Future<void> fetchProductList() async {
//     try {
//       Response response = await dio.get(
//         'https://e-work-backend-production.up.railway.app/products/list',
//       );
//       setState(() {
//         result = response.data ?? {};
//         fetchedProductsList.add(result);
//       });
//       print("Result : \n$result");
//     } catch (e) {
//       print('Error fetching data: $e');
//     }
//   }
//
//   @override
//   void initState() {
//     super.initState();
//
//     // _initializeSavedProducts();
//
//     _animationController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 600),
//       animationBehavior: AnimationBehavior.normal,
//     );
//
//     _animation = Tween<double>(
//       begin: 0.0,
//       end: 1.0,
//     ).animate(_animationController);
//   }
//
//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }
//
//   void _toggleVisibility() {
//     _toggleTextFields = !_toggleTextFields;
//     if (_toggleTextFields) {
//       _animationController.forward();
//     } else {
//       _animationController.repeat();
//     }
//   }
//
//   bool _isTextFieldFilled() {
//     return textEditingNameController.text.isNotEmpty &&
//         textEditingPhoneController.text.isNotEmpty &&
//         textEditingProductController.text.isNotEmpty &&
//         textEditingProductAmountController.text.isNotEmpty;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: ListView(
//         primary: true,
//         children: [
//           Text(
//             'Omborga kirayotgan maxsulotlar',
//             style: TextStyle(
//               fontWeight: FontWeight.w600,
//               fontSize: 20.sp,
//               color: Colors.black87,
//             ),
//             textAlign: TextAlign.center,
//           ),
//           SizedBox(height: _toggleTextFields ? 5 : 30.sp),
//           _toggleTextFields
//               ? MyAnimationBuilder(
//                   animationController: _animationController,
//                   toggleTextFields: _toggleTextFields,
//                   animation: _animation,
//                   textEditingNameController: textEditingNameController,
//                   textEditingPhoneController: textEditingPhoneController,
//                   textEditingProductController: textEditingProductController,
//                   textEditingProductAmountController:
//                       textEditingProductAmountController,
//                 )
//               : savedProductsList.isNotEmpty
//                   ? Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: savedProductsList,
//                     )
//                   : Column(
//                       children: [
//                         Image(
//                           image: const AssetImage(
//                             "assets/images/img_empty_box.png",
//                           ),
//                           height: 120.sp,
//                           width: 120.sp,
//                         ),
//                         SizedBox(height: 20.sp),
//                         Text(
//                           "Qo'shilgan maxsulotlar shu yerda ko'rinadi",
//                           style: TextStyle(
//                             fontWeight: FontWeight.w200,
//                             fontSize: 16.sp,
//                             color: Colors.black87,
//                           ),
//                           textAlign: TextAlign.center,
//                         ),
//                       ],
//                     ),
//           SizedBox(height: _toggleTextFields ? 5 : 30.sp),
//           MyProductAddButton(
//             onPressed: () {
//               if (_isTextFieldFilled()) {
//                 // saveToSqflite();
//               }
//               _toggleVisibility();
//               isButtonTapped = !isButtonTapped;
//               textEditingProductController.clear();
//               textEditingProductAmountController.clear();
//               textEditingNameController.clear();
//               textEditingPhoneController.clear();
//               setState(() {});
//             },
//             buttonText: isButtonTapped ? "Saqlash" : "Maxsulot qo'shish +",
//           ),
//           SizedBox(height: 60.sp),
//         ],
//       ),
//     );
//   }
// }
