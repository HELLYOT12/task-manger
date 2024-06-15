import 'package:flutter/material.dart';

import '../constants/constents.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String? prefixIcon;
  final Icon? suffixIcon;
  final bool? isPassword;
  const CustomTextField({
    super.key,
    this.prefixIcon,
    required this.controller,
    required this.hintText,
    this.suffixIcon, this.isPassword,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: isPassword ?? false,
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: prefixIcon != null?Image.asset(prefixIcon!):null,
        hintText: hintText,
        suffixIcon: suffixIcon,
        hintStyle: const TextStyle(color: Color(0xffC6CEDD)),
        enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: lightSteelBlue)),
        focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xffB9C3D4))),
      ),
    );
  }
}
