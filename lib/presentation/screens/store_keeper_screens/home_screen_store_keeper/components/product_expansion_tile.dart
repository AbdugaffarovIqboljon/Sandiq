import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductExpansionTile extends StatelessWidget {
  const ProductExpansionTile({
    super.key,
    required this.textEditingProductController,
    required this.textEditingProductAmountController,
    required this.textEditingNameController,
    required this.textEditingPhoneController,
  });

  final TextEditingController textEditingProductController;
  final TextEditingController textEditingProductAmountController;
  final TextEditingController textEditingNameController;
  final TextEditingController textEditingPhoneController;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      clipBehavior: Clip.antiAlias,
      childrenPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      backgroundColor: Colors.blueGrey.shade100,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            textEditingProductController.text,
            style: TextStyle(
              fontSize: 17.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            textEditingProductAmountController.text,
            style: TextStyle(
              fontSize: 17.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
      children: [
        Align(
          alignment: const Alignment(-0.97, 0),
          child: Text(
            textEditingNameController.text,
            style: TextStyle(
              fontSize: 17.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Align(
          alignment: const Alignment(-0.97, 0),
          child: Text(
            textEditingPhoneController.text,
            style: TextStyle(
              fontSize: 17.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
