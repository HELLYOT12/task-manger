import 'package:flutter/material.dart';

import '../constants/constents.dart';

class CustomButton extends StatelessWidget {
  final void Function() onTap;
  final String title;
  const CustomButton({super.key, required this.onTap, required this.title});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.only(top: 17, bottom: 14),
        width: MediaQuery.sizeOf(context).width,
        decoration: BoxDecoration(
            color: blueBill, borderRadius: BorderRadius.circular(14)),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }
}
