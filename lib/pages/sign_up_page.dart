import 'package:dalioz/constants/constents.dart';
import 'package:dalioz/widgets/custom_button.dart';
import 'package:dalioz/widgets/custom_textField.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'login_page.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});
  final TextEditingController _controllerUserName = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
            top: MediaQuery.sizeOf(context).height / 10, left: 30, right: 30,bottom: 30),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Sign Up',
                style: TextStyle(
                    fontSize: 32, color: blueBill, fontWeight: FontWeight.w500),
              ),
              Divider(
                endIndent: MediaQuery.sizeOf(context).width / 1.6,
                thickness: 2,
                color: blueBill,
              ),
              SizedBox(
                height: MediaQuery.sizeOf(context).height / 10,
              ),
              CustomTextField(
                  prefixIcon: 'lib/assets/icons/Message.png',
                  controller: _controllerUserName,
                  hintText: 'Username'),
              SizedBox(
                height: MediaQuery.sizeOf(context).height / 20,
              ),
              CustomTextField(
                  prefixIcon: 'lib/assets/icons/Lock.png',
                  controller: _controllerEmail,
                  hintText: 'Email ID'),
              SizedBox(
                height: MediaQuery.sizeOf(context).height / 20,
              ),
              CustomTextField(
                prefixIcon: 'lib/assets/icons/Lock.png',
                controller: _controllerPassword,
                hintText: 'Password',
                isPassword: true,
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                height: MediaQuery.sizeOf(context).height / 20,
              ),
              CustomButton(
                  onTap: () {
                    // TODO: LOGIN METHOD HERE
                  },
                  title: 'Create'),
              SizedBox(
                height: MediaQuery.sizeOf(context).height / 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                      width: MediaQuery.sizeOf(context).width / 3,
                      child: const Divider(color: Color(0xffE3E8F1))),
                  const Text(
                    'or with',
                    style: TextStyle(
                        color: lightSteelBlue,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                  SizedBox(
                      width: MediaQuery.sizeOf(context).width / 3,
                      child: const Divider(
                        color: Color(0xffE3E8F1),
                      ))
                ],
              ),
              SizedBox(
                height: MediaQuery.sizeOf(context).height / 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(5),
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Color(0xffE3E8F1)),
                    ),
                    child:
                    Center(child: Image.asset('lib/assets/icons/google.png')),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.all(5),
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Color(0xffE3E8F1)),
                    ),
                    child: Center(
                        child: Image.asset('lib/assets/icons/Facebook.png')),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.sizeOf(context).height / 20,
              ),
              GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return LoginPage();
                    },));
                  },
                  child: const Center(
                      child: Text(
                        askingForAccountText,
                        style: TextStyle(color: midnightBlue, fontSize: 14),
                      )))
            ],
          ),
        ),
      ),
    );
  }
}
