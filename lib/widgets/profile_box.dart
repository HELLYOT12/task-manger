import 'package:flutter/material.dart';

import '../constants/constents.dart';

class ProfileBox extends StatelessWidget {
  final String title;
  final int numberOfTasks;
  final Color boxThemeColor;
  final String icon;
  const ProfileBox(
      {super.key,
      required this.boxThemeColor,
      required this.icon,
      required this.title, required this.numberOfTasks});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 15),
      width: MediaQuery.sizeOf(context).width / 2.7,
      height: MediaQuery.sizeOf(context).height / 5.4,
      decoration: BoxDecoration(
          color: boxThemeColor.withOpacity(0.24),
          borderRadius: BorderRadius.circular(14)),
      child: Column(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
                color: boxThemeColor, borderRadius: BorderRadius.circular(14)),
            child: Center(child: Image.asset(icon)),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            title,
            style: TextStyle(
                fontSize: 16, fontFamily: 'Roboto-Medium', color: navyBlue),
          ),
          Text(
            title.contains('Create Board') ? '' : 'Tasks $numberOfTasks',
            style: TextStyle(color: Colors.grey, fontSize: 14),
          )
        ],
      ),
    );
  }
}
