import 'package:dalioz/blocs/task_bloc.dart';
import 'package:dalioz/constants/constents.dart';
import 'package:dalioz/pages/home_page.dart';
import 'package:dalioz/pages/root_page.dart';
import 'package:dalioz/utility/utility.dart';
import 'package:dalioz/widgets/back_button.dart';
import 'package:dalioz/widgets/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/Task.dart';

class DetailTaskPage extends StatelessWidget {
  final Task task;
  const DetailTaskPage({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TaskBloc, TaskState>(
        builder: (context, state) {
          return Container(
            margin: EdgeInsets.only(top: kToolbarHeight, left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // back button
                    const CustomBackButton(),
                    // Page Title
                    const Text(
                      'Task Detail',
                      style: TextStyle(color: navyBlue, fontSize: 24),
                    ),
                    // Setting
                    Material(
                        borderRadius: BorderRadius.circular(20),
                        elevation: 5,
                        child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.grey.withOpacity(0.4)),
                                borderRadius: BorderRadius.circular(20)),
                            child: Center(
                                child: Image.asset(
                                    'lib/assets/icons/More-Square.png')))),
                  ],
                ),
                // Task Title,
                Container(
                  margin: EdgeInsets.only(top: 30),
                  child: Text(task.title,
                      style: TextStyle(color: navyBlue, fontSize: 22)),
                ),
                Text("\t\t" + task.taskType.name + " Type",
                    style: TextStyle(color: Colors.grey, fontSize: 15)),
                Container(
                  margin: EdgeInsets.only(top: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.all(20),
                        width: MediaQuery.sizeOf(context).width / 2.3,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          gradient: LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              colors: [
                                Color(0xffFE9D9D),
                                Color(0xffFE9D9D).withOpacity(0.7)
                              ]),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Est. Date',
                              style: TextStyle(
                                  color: Color(0xff707070).withOpacity(0.6),
                                  fontSize: 18),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              '${task.date.day} ${getMonthName(task.date)} ${task.date.year}',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(20),
                        width: MediaQuery.sizeOf(context).width / 2.3,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          gradient: LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              colors: [
                                Color(0xffFE9D9D),
                                Color(0xffFE9D9D).withOpacity(0.7)
                              ]),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Est. Time',
                              style: TextStyle(
                                  color: Color(0xff707070).withOpacity(0.6),
                                  fontSize: 18),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                                '${task.time.hour}:${task.time.minute} ${task.time.period.name}',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18)),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 30),
                          child: const Text('Task description',
                              style: TextStyle(color: navyBlue, fontSize: 22)),
                        ),
                        Container(
                          child: Text(
                            task.des,
                            style: TextStyle(
                                color: navyBlue,
                                fontSize: 17,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 30),
                          child: const Text('Tags',
                              style: TextStyle(color: navyBlue, fontSize: 22)),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        GridView(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 2.9,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                          children: task.tags.map((tag) {
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 10),
                              decoration: BoxDecoration(
                                color: Colors.blue.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Center(
                                child: Text(
                                  tag.name,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        _buttonDepandsOnState(context, task)
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buttonDepandsOnState(BuildContext context, Task task) {
    if (task.taskState == TaskStates.ongoing) {
      return Container(
          margin: const EdgeInsets.only(top: 30, bottom: 20),
          child: CustomButton(
              onTap: () {
                task.taskState = TaskStates.completed;
                context.read<TaskBloc>().add(ChangeTaskStateEvent(task: task));
                Navigator.pop(context);
              },
              title: 'Mark is Completed'));
    } else if (task.taskState == TaskStates.pending) {
      return Container(
          margin: EdgeInsets.only(top: 30, bottom: 20),
          child: CustomButton(
              onTap: () {
                task.taskState = TaskStates.ongoing;
                context.read<TaskBloc>().add(ChangeTaskStateEvent(task: task));
                Navigator.pop(context);
              },
              title: 'Start Task'));
    } else if (task.taskState == TaskStates.canceled) {
      return Container(
          margin: EdgeInsets.only(top: 30, bottom: 20),
          child: CustomButton(
              onTap: () {
                context.read<TaskBloc>().add(RemoveTaskEvent(task: task));
                Navigator.pop(context);
              },
              title: 'Delete Task'));
    } else if (task.taskState == TaskStates.completed) {
      return Container(
          margin: EdgeInsets.only(top: 30, bottom: 20),
          child: CustomButton(
              onTap: () {
                context.read<TaskBloc>().add(RemoveTaskEvent(task: task));
                Navigator.pop(context);
              },
              title: 'Delete Task'));
    }
    return SizedBox();
  }
}
