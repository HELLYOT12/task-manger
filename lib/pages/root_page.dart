import 'package:dalioz/constants/constents.dart';
import 'package:dalioz/pages/Task_page.dart';
import 'package:dalioz/pages/add_task_page.dart';
import 'package:dalioz/pages/home_page.dart';
import 'package:dalioz/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';

import 'graphic_page.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  List<bool> isOneButtonClicked = [false, false, false, false, false];
  int _currentIndex = 0;
  List<Widget> pages = [
    HomePage(),
    TaskPage(),
    AddTaskPage(),
    GraphicPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: SizedBox(
        height: MediaQuery.sizeOf(context).height / 8.2,
        child: DotNavigationBar(
          enablePaddingAnimation: false,
          enableFloatingNavBar: false,
          currentIndex: _currentIndex,
          onTap: (int newValue) {
            setState(() {
              _currentIndex = newValue;
              for (int i = 0; i < isOneButtonClicked.length; i++) {
                if (_currentIndex == i) {
                  isOneButtonClicked[_currentIndex] = true;
                } else {
                  isOneButtonClicked[i] = false;
                }
              }
            });
          },
          items: [
            /// Home
            DotNavigationBarItem(
              icon: Image.asset(
                'lib/assets/icons/Home.png',
                color: isOneButtonClicked[0] ? blueBill : null,
              ),
              selectedColor: blueBill,
            ),

            /// Likes
            DotNavigationBarItem(
              icon: Image.asset(
                'lib/assets/icons/Menu.png',
                color: isOneButtonClicked[1] ? blueBill : null,
              ),
              selectedColor: blueBill,
            ),

            /// Search
            DotNavigationBarItem(
              icon: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: isOneButtonClicked[2] ? blueBill : blueBill,
                  shape: BoxShape.circle,
                ),
                width: 50,
                height: 50,
                child: const Icon(Icons.add_outlined, color: Colors.white),
              ),
              selectedColor: Colors.transparent,
            ),

            /// Profile
            DotNavigationBarItem(
              icon: Image.asset(
                'lib/assets/icons/Activity.png',
                color: isOneButtonClicked[3] ? blueBill : null,
              ),
              selectedColor: blueBill,
            ),

            DotNavigationBarItem(
              icon: Image.asset('lib/assets/icons/Folder.png',
                  color: isOneButtonClicked[4] ? blueBill : null),
              selectedColor: blueBill,
            ),
          ],
        ),
      ),
    );
  }
}
