import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sandiq/domain/model/product.dart';
import 'package:sandiq/services/constants/colors.dart'; // Import your color constants
import 'package:sandiq/services/user_service/token_manager.dart'; // Import TokenManager

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  Dio dio = Dio();
  List<Product> productList = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      String? token = await TokenManager.getToken();
      if (token != null && token.isNotEmpty) {
        Response response = await dio.get(
          'https://e-work-backend-production.up.railway.app/products/sadmin/list',
          options: Options(
            headers: {
              'accept': 'application/json',
              'Authorization': 'Bearer $token',
            },
          ),
        );

        if (response.statusCode == 200) {
          final List<dynamic> data = response.data as List<dynamic>;
          setState(() {
            productList = data.map((json) => Product.fromJson(json)).toList();
          });
        }
      }
    } catch (e) {
      print('Failed to fetch data. Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: CustomColors.kWhite,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          primary: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 50.h),
              Text(
                "Mening maxsulotlarim",
                style: TextStyle(
                  fontSize: 19.sp,
                  color: Colors.grey.shade900,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 20.sp),
              TextField(
                decoration: InputDecoration(
                  isDense: true,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(16),
                    ),
                    borderSide: BorderSide(
                      color: Colors.grey.shade200,
                      width: 2,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(16),
                    ),
                    borderSide: BorderSide(
                      color: Colors.grey.shade200,
                      width: 2,
                    ),
                  ),
                  hintText: "Maxsulotni izlash...",
                ),
              ),
              SizedBox(height: 15.sp),
              Container(
                height: 430.h,
                decoration: BoxDecoration(
                  color: Colors.blueGrey.shade50,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 5,
                    vertical: 5,
                  ),
                  itemCount: productList.length,
                  itemBuilder: (context, index) {
                    final product = productList[index];
                    return ListTile(
                      title: Text(
                        "${index + 1}. ${product.name}",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 18.sp,
                          color: Colors.black87,
                        ),
                      ),
                      trailing: Text(
                        "${product.amount} ${product.size}",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16.sp,
                          color: Colors.black87,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
