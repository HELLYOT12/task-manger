import 'package:flutter/material.dart';

class CustomBackButton extends StatelessWidget { // تغيير اسم الفئة لتجنب التداخل مع الفئة الأصلية BackButton
  const CustomBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Material(
          borderRadius: BorderRadius.circular(20),
          elevation: 5,
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.withOpacity(0.4)),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(child: Image.asset('lib/assets/icons/Arrow-Back.png')),
          ),
        ),
      ),
    );
  }
}
