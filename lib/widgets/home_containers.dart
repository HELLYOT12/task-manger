import 'package:flutter/material.dart';

import '../constants/constents.dart';

class HomeContainerBig extends StatelessWidget {
  final String image;
  final String title;
  final String subTitle;
  final Color elevationColor;
  final Color containerColorBottomLeft;
  final Color containerColorTopRight;
  final Color shadowColor;
  const HomeContainerBig(
      {super.key,
      required this.elevationColor,
      required this.containerColorBottomLeft,
      required this.containerColorTopRight,
      required this.shadowColor,
      required this.image,
      required this.title,
      required this.subTitle});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      color: elevationColor.withOpacity(0.1),
      borderRadius: BorderRadius.circular(14),
      shadowColor: shadowColor.withOpacity(.5),
      child: Container(
        padding: const EdgeInsets.only(top: 10, left: 10,right: 20),
        width: MediaQuery.sizeOf(context).width / 2.5,
        height: MediaQuery.sizeOf(context).height / 5.2,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: [containerColorBottomLeft, containerColorTopRight])),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(image),
                Image.asset('lib/assets/images/Arrow-Right.png')
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              title,
              style: const TextStyle(
                  fontSize: 16, fontFamily: 'Roboto-Medium', color: navyBlue),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              subTitle,
              style: const TextStyle(
                  fontSize: 14, fontFamily: 'Roboto-Regular', color: navyBlue),
            )
          ],
        ),
      ),
    );
  }
}
class HomeContainerMedium extends StatelessWidget {
  final String image;
  final String title;
  final String subTitle;
  final Color elevationColor;
  final Color containerColorBottomLeft;
  final Color containerColorTopRight;
  final Color shadowColor;
  const HomeContainerMedium(
      {super.key,
        required this.elevationColor,
        required this.containerColorBottomLeft,
        required this.containerColorTopRight,
        required this.shadowColor,
        required this.image,
        required this.title,
        required this.subTitle});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      color: elevationColor.withOpacity(0.1),
      borderRadius: BorderRadius.circular(14),
      shadowColor: shadowColor.withOpacity(.5),
      child: Container(
        padding: const EdgeInsets.only(top: 10, left: 10,right: 20),
        width: MediaQuery.sizeOf(context).width / 2,
        height: MediaQuery.sizeOf(context).height / 6,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: [containerColorBottomLeft, containerColorTopRight])),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(image),
                Image.asset('lib/assets/images/Arrow-Right.png',color: Colors.white,)
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              title,
              style: const TextStyle(
                  fontSize: 16, fontFamily: 'Roboto-Medium', color: Colors.white),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              subTitle,
              style: const TextStyle(
                  fontSize: 14, fontFamily: 'Roboto-Regular', color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
