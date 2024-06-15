import 'package:dalioz/constants/constents.dart';
import 'package:dalioz/database/data.dart';
import 'package:dalioz/models/Task.dart';
import 'package:dalioz/utility/utility.dart';
import 'package:dalioz/widgets/custom_category_type_item.dart';
import 'package:dalioz/widgets/profile_box.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
            top: MediaQuery.sizeOf(context).height / 12, left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Material(
                    borderRadius: BorderRadius.circular(20),
                    elevation: 5,
                    child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.grey.withOpacity(0.4)),
                            borderRadius: BorderRadius.circular(20)),
                        child: Center(
                            child: Image.asset(
                                'lib/assets/icons/More-Square.png')))),
              ),
              SizedBox(
                height: 30,
              ),
              Material(
                  borderRadius: BorderRadius.circular(40),
                  elevation: 10,
                  child: Container(
                      width: 85,
                      height: 85,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40)),
                      child: Image.asset('lib/assets/images/Folder.png'))),
              SizedBox(
                height: 20,
              ),
              const Text(
                'Steve Job',
                style: TextStyle(
                    fontSize: 20, fontFamily: 'Roboto-bold', color: navyBlue),
              ),
              const Text(
                'SteveJob@gmail.com',
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'Roboto-Regular',
                    color: Colors.grey),
              ),
              SizedBox(
                height: MediaQuery.sizeOf(context).height / 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return CustomCategoryTypeItem(
                                    pageTitle: 'Personal',
                                    type: TaskType.personal);
                              },
                            ));
                          },
                          child: ProfileBox(
                            boxThemeColor: Color(0xff858FE9),
                            icon: 'lib/assets/icons/Profile.png',
                            title: 'Personal', numberOfTasks: countTaskByType(tasksData, TaskType.personal),
                          )),
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height / 40,
                      ),
                      GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return CustomCategoryTypeItem(
                                    pageTitle: 'Private',
                                    type: TaskType.private);
                              },
                            ));
                          },
                          child: ProfileBox(
                            boxThemeColor: Color(0xffE77D7D),
                            icon: 'lib/assets/icons/Lock-White.png',
                            title: 'Private', numberOfTasks: countTaskByType(tasksData, TaskType.private),
                          )),
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height / 40,
                      ),
                      GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return CustomCategoryTypeItem(
                                    pageTitle: 'Events', type: TaskType.event);
                              },
                            ));
                          },
                          child: ProfileBox(
                            boxThemeColor: Color(0xff858FE9),
                            icon: 'lib/assets/icons/Calendar.png',
                            title: 'Events', numberOfTasks: countTaskByType(tasksData, TaskType.event),
                          )),
                    ],
                  ),
                  Column(
                    children: [
                      GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return CustomCategoryTypeItem(
                                    pageTitle: 'Work', type: TaskType.work);
                              },
                            ));
                          },
                          child: ProfileBox(
                            boxThemeColor: Color(0xff7FC9E7),
                            icon: 'lib/assets/icons/Work.png',
                            title: 'Work', numberOfTasks: countTaskByType(tasksData, TaskType.work),
                          )),
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height / 40,
                      ),
                      GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return CustomCategoryTypeItem(
                                    pageTitle: 'Meeting',
                                    type: TaskType.meeting);
                              },
                            ));
                          },
                          child: ProfileBox(
                            boxThemeColor: Color(0xff81E89E),
                            icon: 'lib/assets/icons/Meeting.png',
                            title: 'Meeting', numberOfTasks: countTaskByType(tasksData, TaskType.meeting),
                          )),
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height / 40,
                      ),
                      ProfileBox(
                        boxThemeColor: Color(0xffF0A58E),
                        icon: 'lib/assets/icons/Plus-Square.png',
                        title: 'Under Work ..', numberOfTasks: 0,
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
