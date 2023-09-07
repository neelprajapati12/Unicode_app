import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  TextEditingController controller;
  String labelText;
  String hintText;
  TextInputType keyboardType;
  String errortext;

  CustomTextField({
    required this.controller,
    required this.labelText,
    required this.errortext,
    this.hintText = '',
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide:
                BorderSide(width: 2, color: Color.fromARGB(255, 42, 66, 140))),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(width: 2, color: Colors.grey)),
        labelText: labelText,
        hintText: hintText,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return errortext;
        }
      },
    );
  }
}
