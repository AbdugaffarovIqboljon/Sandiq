import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sandiq/domain/model/product_model.dart';
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 50),
              Text(
                "Manage Screen",
                style: TextStyle(
                  fontSize: 19.sp,
                  color: Colors.grey.shade900,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 15),
              ListView.separated(
                shrinkWrap: true,
                primary: false,
                itemCount: productList.length,
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemBuilder: (context, index) {
                  return ListTile(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                    ),
                    tileColor: Colors.blueGrey.shade50,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                    title: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        '${productList[index].id}. ${productList[index].name}',
                        style: TextStyle(
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
