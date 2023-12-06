import 'package:flutter/material.dart';
import 'package:sandiq/presentation/screens/manager_role_screen/product_add_screen_manager_role/components/my_dialog.dart';
import 'package:sandiq/presentation/screens/manager_role_screen/product_add_screen_manager_role/components/my_product_add_body.dart';
import 'package:sandiq/services/constants/colors.dart';

class ProductAddScreenManagerRole extends StatefulWidget {
  const ProductAddScreenManagerRole({super.key});

  @override
  State<ProductAddScreenManagerRole> createState() =>
      _ProductAddScreenManagerRoleState();
}

class _ProductAddScreenManagerRoleState
    extends State<ProductAddScreenManagerRole> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.kWhite,
      body: SingleChildScrollView(
        child: MyProductAddBody(
          onPressed: () {
            setState(() {
              showDialog(
                context: context,
                builder: (context) {
                  return const MyDialog();
                },
              );
            });
          },
        ),
      ),
    );
  }
}
