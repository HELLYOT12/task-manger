import 'package:dalioz/constants/constents.dart';
import 'package:dalioz/pages/detail_task_page.dart';
import 'package:dalioz/utility/utility.dart';
import 'package:dalioz/widgets/back_button.dart';
import 'package:dalioz/widgets/custom_searchbar.dart';
import 'package:dalioz/widgets/task_design.dart';
import 'package:flutter/material.dart';

import '../database/data.dart';
import '../models/Task.dart';

class TodayTaskPage extends StatefulWidget {
  const TodayTaskPage({super.key});

  @override
  State<TodayTaskPage> createState() => _TodayTaskPageState();
}

class _TodayTaskPageState extends State<TodayTaskPage> {
  List<List<Task>> tasksByTime = getTasksByHour(tasksData);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
            top: MediaQuery.sizeOf(context).height / 20, left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomBackButton(),
              SizedBox(height: 20),
              CustomSearchBar(widthPres: 1),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Today Tasks', style: TextStyle(fontSize: 24, fontFamily: 'Roboto-Bold')),
                  Text('${timeLeftInDay().inHours}h left'),
                ],
              ),
              SizedBox(height: 20),
              Divider(color: Color(0xffE3E8F1)),
              ..._buildTaskSections(),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildTaskSections() {
    List<String> timeSlots = [
      '1 to 4 AM',
      '5 to 8 AM',
      '9 to 12 AM',
      '1 to 4 PM',
      '5 to 8 PM',
      '9 to 12 PM'
    ];
    List<Widget> taskSections = [];

    for (int i = 0; i < tasksByTime.length; i++) {
      if (tasksByTime[i].isNotEmpty) {

        taskSections.add(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(timeSlots[i], style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500,color: navyBlue)),
              SizedBox(height: 10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: tasksByTime[i].map((task) {
                    if (task.taskState != TaskStates.ongoing){
                      return SizedBox();
                    }
                    return Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return DetailTaskPage(task: task);
                          },));
                        },
                        child: TaskDesign(taskThemeColor: getTaskColorByState(task), task: task, widthRatio: 1.4,)),
                  );
                  }).toList(),
                ),
              ),
              const Divider(color: Color(0xffE3E8F1)),
            ],
          ),
        );
      }
    }
    return taskSections;
  }
}
