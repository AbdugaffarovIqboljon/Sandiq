import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sandiq/domain/model/product_delivery.dart';
import 'package:sandiq/domain/model/product_model.dart';
import 'package:sandiq/presentation/screens/store_keeper_screens/home_screen_store_keeper/components/product_add_button.dart';

import '../components/animation_builder_incoming_product_screen.dart';

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
  bool isListTileTapped = false;

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
        deliveryPhone: textEditingPhoneController.text,
        status: true,
      );
    } catch (e, l) {
      print('Error fetching data: $e');
      print('Location of fetching data: $l');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchIncomingProducts();
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
          SizedBox(height: 10.sp),
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
                  ? ListView.separated(
                      separatorBuilder: (_, __) => const SizedBox(height: 8),
                      shrinkWrap: true,
                      itemCount: productList.length,
                      itemBuilder: (context, index) {
                        final deliveredProduct = productList[index];
                        return isListTileTapped == false
                            ? ListTile(
                                onTap: () {
                                  isListTileTapped = !isListTileTapped;
                                  setState(() {});
                                },
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(18),
                                  ),
                                  side: BorderSide.none,
                                ),
                                tileColor: Colors.blueGrey.shade50,
                                title: Text(
                                  '${index + 1}. ${deliveredProduct.productBaseInfo.productName}',
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                trailing: Text(
                                  '${deliveredProduct.productBaseInfo.amount} ${deliveredProduct.productBaseInfo.size}',
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              )
                            : ListTile(
                                onTap: () {
                                  isListTileTapped = !isListTileTapped;
                                  setState(() {});
                                },
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(18),
                                  ),
                                  side: BorderSide.none,
                                ),
                                tileColor: Colors.blueGrey.shade50,
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 5),
                                    Text(
                                      'Maxsulot: ${deliveredProduct.productBaseInfo.productName} \t${deliveredProduct.productBaseInfo.amount.toString()} ${deliveredProduct.productBaseInfo.size.toString()}',
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      "Ismi: ${deliveredProduct.deliveryInfo.name}",
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      "Telefon raqami: ${deliveredProduct.deliveryInfo.phone}",
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      "Sanasi: ${deliveredProduct.productBaseInfo.createdAt}",
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
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

class ProductTypeSelector extends StatefulWidget {
  final ProductService productService;
  final void Function(Product)? onSelected;
  final TextEditingController textEditingController;

  const ProductTypeSelector({
    Key? key,
    required this.productService,
    this.onSelected,
    required this.textEditingController,
  }) : super(key: key);

  @override
  State<ProductTypeSelector> createState() => _ProductTypeSelectorState();
}

class _ProductTypeSelectorState extends State<ProductTypeSelector> {
  late Future<List<Product>> productsFuture;
  Product? selectedProduct;

  @override
  void initState() {
    super.initState();
    productsFuture = widget.productService.fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (selectedProduct != null)
          ListTile(
            tileColor: Colors.blueGrey.shade50,
            shape: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
              borderSide: BorderSide.none,
            ),
            title: Text(
              selectedProduct!.name,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Colors.grey.shade700,
              ),
            ),
            onTap: () {
              setState(() {
                selectedProduct = null;
              });
            },
          )
        else
          FutureBuilder<List<Product>>(
            future: productsFuture,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final products = snapshot.data!;
                return DropdownButtonFormField2<Product>(
                  barrierDismissible: true,
                  dropdownStyleData: DropdownStyleData(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                      color: Colors.blueGrey.shade50,
                    ),
                    padding: EdgeInsets.only(bottom: 20),
                  ),
                  items: products.map((product) {
                    return DropdownMenuItem<Product>(
                      value: product,
                      child: ListTile(
                        title: Text(product.name),
                        subtitle: Text(product.size),
                      ),
                    );
                  }).toList(),
                  onChanged: (Product? newValue) {
                    if (widget.onSelected != null && newValue != null) {
                      widget.onSelected!(newValue);
                      setState(() {
                        selectedProduct = newValue;
                        selectedProductId = selectedProduct?.id ?? 0;
                      });
                    }
                  },
                  decoration: InputDecoration(
                    enabled: true,
                    isCollapsed: true,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(21),
                      borderSide: BorderSide.none,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(21),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.blueGrey.shade50,
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 10,
                    ),
                  ),
                  isExpanded: false,
                  hint: Text(
                    "Maxsulotni tanlang",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  selectedItemBuilder: (BuildContext context) {
                    return products.map<Widget>((Product product) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(12),
                          ),
                          color: Colors.blueGrey.shade50,
                        ),
                        width: 1,
                        child: ListTile(
                          title: Text(product.name),
                          subtitle: Text(product.size),
                        ),
                      );
                    }).toList();
                  },
                );
              } else if (snapshot.hasError) {
                return Text('Error fetching products: ${snapshot.error}');
              } else {
                return const CircularProgressIndicator.adaptive();
              }
            },
          ),
      ],
    );
  }
}

// class ProductTypeSelector extends StatefulWidget {
//   final ProductService productService;
//   final void Function(Product)? onSelected;
//
//   final TextEditingController textEditingController;
//
//   const ProductTypeSelector({
//     Key? key,
//     required this.productService,
//     this.onSelected,
//     required this.textEditingController,
//   }) : super(key: key);
//
//   @override
//   State<ProductTypeSelector> createState() => _ProductTypeSelectorState();
// }
//
// class _ProductTypeSelectorState extends State<ProductTypeSelector> {
//   late Future<List<Product>> productsFuture;
//   Product? selectedProduct;
//
//   @override
//   void initState() {
//     super.initState();
//     productsFuture = widget.productService.fetchProducts();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       clipBehavior: Clip.antiAlias,
//       decoration: BoxDecoration(
//         color: Colors.blueGrey.shade50,
//         borderRadius: const BorderRadius.all(
//           Radius.circular(20),
//         ),
//       ),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           if (selectedProduct != null)
//             ListTile(
//               shape: const OutlineInputBorder(
//                 borderRadius: BorderRadius.all(
//                   Radius.circular(25),
//                 ),
//               ),
//               title: Text(
//                 selectedProduct!.name,
//                 style: TextStyle(
//                   fontWeight: FontWeight.w600,
//                   fontSize: 16.sp,
//                   color: Colors.grey.shade700,
//                 ),
//               ),
//               onTap: () {
//                 setState(() {
//                   selectedProduct = null;
//                 });
//               },
//             )
//           else
//             FutureBuilder<List<Product>>(
//               future: productsFuture,
//               builder: (context, snapshot) {
//                 if (snapshot.hasData) {
//                   final products = snapshot.data!;
//                   return Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 12.0),
//                     child: TypeAheadField<Product>(
//                       hideWithKeyboard: false,
//                       decorationBuilder: (context, child) {
//                         return Material(
//                           type: MaterialType.card,
//                           elevation: 2,
//                           color: Colors.white,
//                           clipBehavior: Clip.antiAlias,
//                           borderRadius: BorderRadius.circular(30),
//                           child: child,
//                         );
//                       },
//                       suggestionsCallback: (search) async => products
//                           .where((product) => product.name
//                               .toLowerCase()
//                               .startsWith(search.toLowerCase()))
//                           .toList(),
//                       itemBuilder: (context, suggestion) => ListTile(
//                         title: Text(suggestion.name),
//                         subtitle: Text(suggestion.size),
//                       ),
//                       emptyBuilder: (context) => Padding(
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 18.0,
//                           vertical: 8.0,
//                         ),
//                         child: Text(
//                           "Maxsulot topilmadi!",
//                           style: TextStyle(
//                             fontSize: 17,
//                             fontWeight: FontWeight.w500,
//                             color: Colors.grey.shade800,
//                           ),
//                         ),
//                       ),
//                       onSelected: (product) {
//                         if (widget.onSelected != null) {
//                           widget.onSelected!(product);
//                           setState(() {
//                             selectedProduct = product;
//                             selectedProductId = selectedProduct?.id ?? 0;
//                           });
//                         }
//                       },
//                     ),
//                   );
//                 } else if (snapshot.hasError) {
//                   return Text('Error fetching products: ${snapshot.error}');
//                 } else {
//                   return const CircularProgressIndicator.adaptive();
//                 }
//               },
//             ),
//         ],
//       ),
//     );
//   }
// }
