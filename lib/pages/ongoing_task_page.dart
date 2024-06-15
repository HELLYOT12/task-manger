import 'package:dalioz/constants/constents.dart';
import 'package:dalioz/utility/utility.dart';
import 'package:dalioz/widgets/back_button.dart';
import 'package:dalioz/widgets/popover_task_body.dart';
import 'package:dalioz/widgets/task_design_general.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';

import '../blocs/task_bloc.dart';
import '../database/data.dart';
import '../models/Task.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_searchbar.dart';

class OngoingTaskPage extends StatefulWidget {
  const OngoingTaskPage({super.key});

  @override
  State<OngoingTaskPage> createState() => _OngoingTaskPageState();
}

class _OngoingTaskPageState extends State<OngoingTaskPage> {
  DateTime showTasksByDate = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  List<Task> tasksByState = [];

  @override
  void initState() {
    super.initState();
    tasksByState = getTaskByState(tasksData, TaskStates.ongoing);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: kToolbarHeight, left: 20, right: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const CustomBackButton(),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width / 6,
                  ),
                  const Text(
                    'On Going Tasks',
                    style: TextStyle(
                        color: navyBlue,
                        fontSize: 20,
                        fontWeight: FontWeight.w400),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomSearchBar(widthPres: 1.4),
                  Container(
                    padding: EdgeInsets.all(8),
                    width: 50,
                    height: 50,
                    child: Image.asset('lib/assets/icons/serach-setting.png'),
                    decoration: BoxDecoration(
                        color: lightSteelBlue,
                        borderRadius: BorderRadius.circular(14)),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'lib/assets/icons/Calendar.png',
                    color: navyBlue,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return SingleChildScrollView(
                            child: AlertDialog(
                              surfaceTintColor: Colors.white,
                              elevation: 10,
                              contentPadding:
                              const EdgeInsets.only(top: 20, bottom: 20),
                              content: StatefulBuilder(
                                builder: (BuildContext context,
                                    StateSetter setState) {
                                  return Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SizedBox(
                                        width: MediaQuery.sizeOf(context).width,
                                        height:
                                        MediaQuery.sizeOf(context).height /
                                            2,
                                        child: TableCalendar(
                                          onDaySelected:
                                              (selectedDay, focusedDay) {
                                            setState(() {
                                              showTasksByDate = selectedDay;
                                              _focusedDay = focusedDay;
                                            });
                                          },
                                          focusedDay: _focusedDay,
                                          selectedDayPredicate: (day) {
                                            return isSameDay(
                                                showTasksByDate, day);
                                          },
                                          firstDay: DateTime(2024, 1, 1),
                                          lastDay: DateTime.now(),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                              actions: [
                                CustomButton(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  title: 'Cancel',
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                CustomButton(
                                  onTap: () {
                                    setState(() {
                                      Navigator.pop(context);
                                    });
                                  },
                                  title: 'Save',
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: Text(
                      '${getMonthName(showTasksByDate)} ${showTasksByDate.year}',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: navyBlue),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              BlocBuilder<TaskBloc, TaskState>(
                builder: (context, state) {
                  if (state is TaskChangedState) {
                    tasksByState = getTaskByState(state.tasks, TaskStates.ongoing);
                    if (tasksByState.isEmpty) {
                      return const Center(
                          child: Text(
                            'No OnGoing tasks Available',
                            style: TextStyle(fontSize: 20, color: Colors.grey),
                          ));
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: groupTasksByDate(tasksByState).entries.map((item) {
                        if (item.key.year == showTasksByDate.year &&
                            item.key.month == showTasksByDate.month) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${item.key.year} ${getMonthName(item.key)} ${item.key.day} ',
                                style: TextStyle(color: navyBlue.withOpacity(0.7)),
                              ),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    for (var task in item.value)
                                      if (task.taskState == TaskStates.ongoing)
                                        TaskDesignGeneral(
                                          taskThemeColor: onGoingColor,
                                          taskColor: onGoingColor.withOpacity(0.2),
                                          task: task,
                                          menuBody: PopOverBodyOngoing(task: task),
                                        )
                                      else
                                        SizedBox(),
                                  ],
                                ),
                              ),
                            ],
                          );
                        } else {
                          return const SizedBox();
                        }
                      }).toList(),
                    );
                  }
                  return const SizedBox();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
