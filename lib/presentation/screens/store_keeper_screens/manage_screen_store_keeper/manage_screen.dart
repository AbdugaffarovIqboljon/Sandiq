import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sandiq/domain/model/product.dart';
import 'package:sandiq/services/constants/colors.dart';

class ManageScreenStoreKeeper extends StatefulWidget {
  const ManageScreenStoreKeeper({super.key});

  @override
  State<ManageScreenStoreKeeper> createState() =>
      _ManageScreenStoreKeeperState();
}

class _ManageScreenStoreKeeperState extends State<ManageScreenStoreKeeper> {
  final ProductService productService = ProductService();
  List<Product> productList = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      await productService.editProduct(
        productId: 1,
        amount: 5,
        description: 'Example description',
        deliveryName: 'John Doe',
        deliveryPhone: '+1234567890',
        status: true,
      );

      List<Product> fetchedProducts = await productService.fetchProducts();
      setState(() {
        productList = fetchedProducts;
      });
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.kWhite,
      body: Column(
        children: [
          const SizedBox(height: 60),
          Center(
            child: Text(
              "Manage Screen",
              style: TextStyle(
                fontSize: 21.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: productList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    'Product ID: ${productList[index].id}',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  subtitle: Text(
                    'Name: ${productList[index].name}',
                    style: TextStyle(
                      fontSize: 14.sp,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
