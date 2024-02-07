import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sandiq/domain/model/product_model.dart';
import 'package:sandiq/presentation/screens/manager_role_screen/home_screen_manager_role/components/my_card.dart';
import 'package:sandiq/services/constants/colors.dart';

import '../../../../domain/model/raw_materials_model.dart';

class HomeScreenManagerRole extends StatefulWidget {
  const HomeScreenManagerRole({Key? key}) : super(key: key);

  @override
  State<HomeScreenManagerRole> createState() => _HomeScreenManagerRoleState();
}

class _HomeScreenManagerRoleState extends State<HomeScreenManagerRole> {
  late ProductService productService;
  List<MyCard> products = [];
  RawMaterials? rawMaterials;

  @override
  void initState() {
    super.initState();
    productService = ProductService();
    fetchHomeDataManagerRole();
  }

  Future<void> fetchHomeDataManagerRole() async {
    RawMaterials? data = await productService.fetchHomeDataManagerRole(2);

    if (data != null) {
      setState(() {
        rawMaterials = data;
        products = rawMaterials!.productSets
            .expand((set) => set.dataArray)
            .expand((data) => data.products)
            .map((product) {
          String productName = product.name;
          String productPrice = product.price;
          String productAmount = product.amount;
          String productSize = product.size;
          String totalPrice = rawMaterials!.totalPrice.toString();
          return MyCard(
            product: productName,
            price: "$productPrice so'm",
            totalPrice: "$totalPrice so'm",
            volume: "$productAmount $productSize",
          );
        }).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: CustomColors.kWhite,
      body: SingleChildScrollView(
        primary: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 36),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              const Text(
                'Xomashyolar',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 5),
              SizedBox(
                height: 570.sp,
                child: ListView.builder(
                  primary: true,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return products.isEmpty
                        ? const CircularProgressIndicator.adaptive()
                        : products[index];
                  },
                  itemCount: products.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
