import 'package:dalioz/pages/login_page.dart';
import 'package:dalioz/pages/sign_up_page.dart';
import 'package:dalioz/widgets/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/constents.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
            left: 25,
            right: 25,
            top: MediaQuery.sizeOf(context).height / 6.5,
            bottom: 40),
        child: Column(
          children: [
            Center(child: Image.asset(splashImageLogo)),
            SizedBox(
              height: MediaQuery.sizeOf(context).height / 17,
            ),
            const Text(
              splashTitle,
              style: TextStyle(fontSize: 32, color: blueBill),
            ),
            const Text(
              splashDes,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: midnightBlue),
            ),
            SizedBox(
              height: MediaQuery.sizeOf(context).height / 17,
            ),
            CustomButton(onTap: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                  return LoginPage();
                },));

            }, title: 'Login'),
            SizedBox(
              height: MediaQuery.sizeOf(context).height / 40,
            ),
            GestureDetector(
              onTap:  () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                  return SignUpPage();
                },));
              },
              child:  Text(
                'Sign Up',
                style: TextStyle(
                    color: blueBill, fontFamily: 'Roboto-Bold', fontSize: 16),
              ),
            )
          ],
        ),
      ),
    );
  }
}
