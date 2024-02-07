import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sandiq/domain/model/product_model.dart';
import 'package:sandiq/presentation/screens/manager_role_screen/components/add_screen_button.dart';
import 'package:sandiq/presentation/screens/store_keeper_screens/home_screen_store_keeper/components/product_type_selector.dart';

import 'my_text_field_add.dart';

List<Product> savedProducts = [];
List<int> amounts = [];
int amountControlling = 0;

class MyDialog extends StatefulWidget {
  final VoidCallback onProductAdded;

  const MyDialog({super.key, required this.onProductAdded});

  @override
  State<MyDialog> createState() => _MyDialogState();
}

class _MyDialogState extends State<MyDialog> {
  TextEditingController productController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  ProductService productService = ProductService();

  Product? selectedProduct;

  void updateSelectedProduct(Product product) {
    setState(() {
      selectedProduct = product;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 0,
      backgroundColor: Colors.white,
      content: SizedBox(
        height: 350.sp,
        width: 300.sp,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text(
                  "Maxsulot qo'shish",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(CupertinoIcons.xmark, size: 22),
                ),
              ],
            ),
            ProductTypeSelector(
              productService: productService,
              textEditingController: productController,
              onSelected: updateSelectedProduct,
            ),
            MyTextFieldAdd(
              hinText: 'Miqdorni kiriting',
              controller: amountController,
              suffixText: selectedProduct != null ? selectedProduct?.size : '',
              action: TextInputAction.done,
            ),
            AddScreenManagerButton(
              fontSize: 15.sp,
              width: 300.sp,
              displayText: "Qo'shish +",
              onPressed: () {
                if (selectedProduct != null) {
                  int enteredAmount = int.tryParse(amountController.text) ?? 0;
                  savedProducts.add(selectedProduct!);
                  amounts.add(enteredAmount);
                  widget.onProductAdded(); // Notify the parent widget
                  setState(() {});
                  Navigator.pop(context);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
