import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sandiq/services/constants/colors.dart';
import 'my_text_field_add.dart';

// ignore: must_be_immutable
class MyDialog extends StatefulWidget {
  const MyDialog({super.key});

  @override
  State<MyDialog> createState() => _MyDialogState();
}

class _MyDialogState extends State<MyDialog> {
  TextEditingController productController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: CustomColors.kWhite,
      content: SizedBox(
        height: 300,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Mahsulot qo\'shish',
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
            MyTextFieldAdd(
              text: 'Mahsulotni tanlang',
              controller: productController,
              action: TextInputAction.next,
            ),
            MyTextFieldAdd(
              text: 'Miqdorni kiriting',
              controller: amountController,
              icon: Icons.abc,
              action: TextInputAction.done,
            ),
            InkWell(
              onTap: () {
                setState(() {});
              },
              child: Container(
                width: double.infinity,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: productController.text.isNotEmpty &&
                          amountController.text.isNotEmpty
                      ? CustomColors.kPrimaryColor
                      : CustomColors.kPrimaryColor.withOpacity(.3),
                ),
                alignment: Alignment.center,
                child: Text(
                  'Qo\'shish +',
                  style: TextStyle(
                    color: CustomColors.kWhite,
                    fontWeight: FontWeight.w600,
                    letterSpacing: .5,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
