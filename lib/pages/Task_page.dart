import 'package:dalioz/constants/constents.dart';
import 'package:dalioz/utility/utility.dart';
import 'package:dalioz/widgets/custom_searchbar.dart';
import 'package:dalioz/widgets/task_design.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/widgets.dart';

import '../database/data.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
            top: MediaQuery.sizeOf(context).height / 9.5, left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomSearchBar(widthPres: 1),
              SizedBox(
                height: 20,
              ),
              Text(
                'Task',
                style: TextStyle(fontSize: 24, fontFamily: 'Roboto-Bold'),
              ),
              EasyDateTimeLine(
                  onDateChange: (selectedDate) {
                    setState(() {
                      _selectedDate = selectedDate;
                    });
                  },
                  initialDate: DateTime(DateTime.now().year,
                      DateTime.now().month, DateTime.now().day)),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    DateTime.now().day == _selectedDate?.day &&
                            DateTime.now().month == _selectedDate?.month &&
                            DateTime.now().year == _selectedDate?.year
                        ? 'Today'
                        : getDayName(_selectedDate!),
                    style: const TextStyle(fontSize: 24, fontFamily: 'Roboto-Bold'),
                  ),
                  Text(timeLeftInDay().inHours.toString() + 'h' + ' left'),
                ],
              ),
              SizedBox(height: 20),
              Divider(
                color: Color(0xffE3E8F1),
              ),
              if (_selectedDate != null)
                if (getTasksByDate(tasksData, _selectedDate).isNotEmpty)
                  for (var task in getTasksByDate(tasksData, _selectedDate!))
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: TaskDesign(
                        taskThemeColor: getTaskColorByState(task),
                        task: task, widthRatio: 1.1,
                      ),
                    )
                else
                  const Padding(
                    padding: EdgeInsets.only(top: 50),
                    child: Center(
                        child: Text(
                      'No Tasks available On This Day',
                      style: TextStyle(
                          color: navyBlue,
                          fontSize: 19,
                          fontWeight: FontWeight.w300),
                    )),
                  )
            ],
          ),
        ),
      ),
    );
  }
}
