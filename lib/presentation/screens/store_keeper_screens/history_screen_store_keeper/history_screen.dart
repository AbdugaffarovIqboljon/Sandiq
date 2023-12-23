import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sandiq/domain/model/product_history_model.dart';
import 'package:sandiq/domain/model/product_model.dart';
import 'package:sandiq/services/constants/colors.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  late Future<List<ProductHistory>> productsFuture;
  ProductService productService = ProductService();

  @override
  void initState() {
    productsFuture = productService.fetchProductHistory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: CustomColors.kWhite,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: FutureBuilder<List<ProductHistory>>(
          future: productsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else if (!snapshot.hasData || (snapshot.data?.isEmpty ?? true)) {
              return const Center(
                child: Text('No data available'),
              );
            } else {
              List<ProductHistory> productHistory = snapshot.data ?? [];
              productHistory = productHistory.reversed.toList();
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 50.h),
                  Text(
                    "Maxsulotlar tarixi",
                    style: TextStyle(
                      fontSize: 19.sp,
                      color: Colors.grey.shade900,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    decoration: InputDecoration(
                      isDense: true,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(15),
                        ),
                        borderSide: BorderSide(
                          color: Colors.grey.shade200,
                          width: 2,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(15),
                        ),
                        borderSide: BorderSide(
                          color: Colors.grey.shade200,
                          width: 2,
                        ),
                      ),
                      hintText: "Maxsulotni izlash...",
                    ),
                  ),
                  SizedBox(height: 10.sp),
                  SizedBox(
                    height: 450.h,
                    child: ListView.separated(
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 5,
                        vertical: 5,
                      ),
                      itemCount: productHistory.length,
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 10,
                      ),
                      itemBuilder: (context, index) {
                        final product = productHistory[index];
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.blueGrey.shade50,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(13),
                            ),
                          ),
                          child: ListTile(
                            title: Text(
                              "${index + 1}. ${product.name}",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 18.sp,
                                color: Colors.black87,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${product.delivery.phone}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18.sp,
                                    color: Colors.black87,
                                  ),
                                ),

                                Text(
                                  "${product.delivery.name}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18.sp,
                                    color: Colors.black87,
                                  ),
                                ),

                                Text(
                                  "${product.warehouse.name}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18.sp,
                                    color: Colors.black87,
                                  ),
                                ),

                                Text(
                                  "${product.warehouse.address}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18.sp,
                                    color: Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                product.status == false
                                    ? Image(
                                        image: const AssetImage(
                                          "assets/icons/ic_chart_rise.png",
                                        ),
                                        color: Colors.green,
                                        height: 20.sp,
                                      )
                                    : Image(
                                        image: const AssetImage(
                                          "assets/icons/ic_chart_decrease.png",
                                        ),
                                        height: 20.sp,
                                      ),
                                const SizedBox(width: 15),
                                Text(
                                  "${product.amount} ${product.size}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16.sp,
                                    color: Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
