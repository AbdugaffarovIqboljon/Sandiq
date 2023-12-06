import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String text;

  const MyTextField({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 30),
      child: TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
          ),
          hintText: text,
          hintStyle: TextStyle(fontSize: 12, color: Colors.grey.shade400),
        ),
      ),
    );
  }
}
