import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sandiq/domain/model/product_model.dart';
import 'package:sandiq/presentation/screens/manager_role_screen/components/add_screen_button.dart';
import 'package:sandiq/presentation/screens/manager_role_screen/product_add_screen_manager_role/components/my_dialog.dart';
import 'package:sandiq/services/constants/colors.dart';

import 'components/my_text_field_add.dart';

class ProductAddScreenManagerRole extends StatefulWidget {
  const ProductAddScreenManagerRole({super.key});

  @override
  State<ProductAddScreenManagerRole> createState() =>
      _ProductAddScreenManagerRoleState();
}

class _ProductAddScreenManagerRoleState
    extends State<ProductAddScreenManagerRole> {
  TextEditingController descriptionController = TextEditingController();
  ProductService productService = ProductService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.kWhite,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 20.sp, right: 20.sp, top: 50.sp),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Buyurtma qilish',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                  ),

                  /// #Add Button
                  InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return MyDialog(
                            onProductAdded: () {
                              setState(() {});
                            },
                          );
                        },
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: CustomColors.kPrimaryColor,
                      ),
                      alignment: Alignment.center,
                      width: 160.sp,
                      height: 50.sp,
                      child: Text(
                        "Maxsulot qo'shish +",
                        style: TextStyle(
                          fontSize: 15.5.sp,
                          fontWeight: FontWeight.w500,
                          color: CustomColors.kWhite,
                        ),
                        maxLines: 1,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: savedProducts.isEmpty ? 150.sp : 20.sp),
              savedProducts.isEmpty
                  ? Image.asset(
                      'assets/images/img_empty_box.png',
                      height: 120.sp,
                      width: 120.sp,
                    )
                  : Column(
                      children: [
                        Container(
                          height: 200.sp,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.blueGrey.shade50,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(13),
                            ),
                          ),
                          child: SingleChildScrollView(
                            primary: true,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 10),
                                Text(
                                  "Maxsulotlar ro'yxati:",
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  padding: EdgeInsets.zero,
                                  itemCount: savedProducts.length,
                                  itemBuilder: (context, index) {
                                    final mySavedProducts =
                                        savedProducts[index];
                                    return Column(
                                      children: [
                                        const SizedBox(height: 10),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "${index + 1}. ${mySavedProducts.name}:",
                                              style: TextStyle(
                                                fontSize: 18.sp,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            Text(
                                              "${amounts[index]} ${mySavedProducts.size}",
                                              style: TextStyle(
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        MyTextFieldAdd(
                          controller: descriptionController,
                          action: TextInputAction.done,
                          hinText: "Izoh qoldirish",
                        ),
                        const SizedBox(height: 20),
                        AddScreenManagerButton(
                          fontSize: 18.sp,
                          width: 390.sp,
                          displayText: "Saqlash \t\t\u2705",
                          onPressed: () async {
                            List<Map<String, Object?>> productsList = [];

                            for (int i = 0; i < savedProducts.length; i++) {
                              productsList.add({
                                'name': savedProducts[i].name,
                                'product': savedProducts[i].id,
                                'amount': amounts[i],
                              });
                            }

                            Map<String, Object?> requestBody = {
                              'products': productsList,
                              'object': 2,
                              'description': descriptionController.text,
                            };

                            bool success = await productService
                                .postDataToBackend(requestBody);

                            if (success) {
                              setState(() {
                                savedProducts.clear();
                                amounts.clear();
                              });

                              if (mounted) {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      backgroundColor: Colors.white,
                                      content: Text(
                                        "Muvaffaqiyatli jo'natildi",
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    );
                                  },
                                );
                              }

                              Future.delayed(const Duration(seconds: 1), () {
                                Navigator.of(context).pop();
                              });
                            } else {}
                          },
                        ),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
