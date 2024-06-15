import 'package:dalioz/blocs/task_bloc.dart';
import 'package:dalioz/constants/constents.dart';
import 'package:dalioz/models/Task.dart';
import 'package:dalioz/pages/canceled_task_page.dart';
import 'package:dalioz/pages/completed_task_page.dart';
import 'package:dalioz/pages/detail_task_page.dart';
import 'package:dalioz/pages/ongoing_task_page.dart';
import 'package:dalioz/pages/pending_task_page.dart';
import 'package:dalioz/pages/today_tasks_page.dart';
import 'package:dalioz/utility/utility.dart';
import 'package:dalioz/widgets/home_containers.dart';
import 'package:dalioz/widgets/task_design.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphic/graphic.dart';

import '../database/data.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context.read<TaskBloc>().emit(TaskChangedState(tasks: tasksData));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.only(
                top: MediaQuery.sizeOf(context).height / 17,
                left: 15,
                right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Hi,Steven',
                  style: TextStyle(
                      color: navyBlue, fontSize: 28, fontFamily: 'Roboto-Bold'),
                ),
                const Text(
                  'Let’s make this day productive',
                  style: TextStyle(color: Color(0xff575757)),
                ),
                SizedBox(
                  height: MediaQuery.sizeOf(context).height / 25,
                ),
                const Text(
                  'My Tasks',
                  style: TextStyle(
                      color: navyBlue, fontSize: 24, fontFamily: 'Roboto-Bold'),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: MediaQuery.sizeOf(context).width,
                  child: BlocBuilder<TaskBloc, TaskState>(
                    builder: (context, state) {
                      return Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CompletedTaskPage(),
                                  ));
                            },
                            child: HomeContainerBig(
                                elevationColor: const Color(0xff7DC8E7),
                                containerColorBottomLeft:
                                    const Color(0xff7DC8E7),
                                containerColorTopRight:
                                    const Color(0xff7DC8E7).withOpacity(0.60),
                                shadowColor:
                                    const Color(0xff7DC8E7).withOpacity(.2),
                                image: 'lib/assets/images/iMac 1.png',
                                title: 'Completed',
                                subTitle:
                                    '${countTaskByState(tasksData, TaskStates.completed)} Tasks'),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PendingTaskPage(),
                                  ));
                            },
                            child: HomeContainerMedium(
                                elevationColor: const Color(0xff7D88E7),
                                containerColorBottomLeft:
                                    const Color(0xff7D88E7),
                                containerColorTopRight:
                                    const Color(0xff7D88E7).withOpacity(0.60),
                                shadowColor:
                                    const Color(0xff7D88E7).withOpacity(.2),
                                image: 'lib/assets/icons/Time-Square.png',
                                title: 'Pending',
                                subTitle:
                                    '${countTaskByState(tasksData, TaskStates.pending)} Tasks'),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: MediaQuery.sizeOf(context).height / 100,
                ),
                SizedBox(
                  width: MediaQuery.sizeOf(context).width,
                  child: BlocBuilder<TaskBloc, TaskState>(
                    builder: (context, state) {
                      return Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CanceledTaskPage(),
                                  ));
                            },
                            child: HomeContainerMedium(
                                elevationColor: const Color(0xffE77D7D),
                                containerColorBottomLeft:
                                    const Color(0xffE77D7D),
                                containerColorTopRight:
                                    const Color(0xffE77D7D).withOpacity(0.60),
                                shadowColor:
                                    const Color(0xffE77D7D).withOpacity(.2),
                                image: 'lib/assets/icons/Close Square.png',
                                title: 'Canceled',
                                subTitle:
                                    '${countTaskByState(tasksData, TaskStates.canceled)} Tasks'),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => OngoingTaskPage(),
                                  ));
                            },
                            child: HomeContainerBig(
                                elevationColor: const Color(0xff81E89E),
                                containerColorBottomLeft:
                                    const Color(0xff81E89E),
                                containerColorTopRight:
                                    const Color(0xff81E89E).withOpacity(0.38),
                                shadowColor:
                                    const Color(0xff81E89E).withOpacity(.2),
                                image: 'lib/assets/images/Folder.png',
                                title: 'on Going',
                                subTitle:
                                    '${countTaskByState(tasksData, TaskStates.ongoing)} Tasks'),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Today Task',
                      style: TextStyle(
                          color: navyBlue,
                          fontSize: 24,
                          fontFamily: 'Roboto-Bold'),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return TodayTaskPage();
                          },
                        ));
                      },
                      child: const Text(
                        'View All',
                        style: TextStyle(
                            color: navyBlue,
                            fontSize: 14,
                            fontWeight: FontWeight.w300),
                      ),
                    ),
                  ],
                ),
                BlocBuilder<TaskBloc, TaskState>(
                  builder: (context, state) {
                    List<Task> todayTasks = getTodayTasks(tasksData);
                    if (todayTasks.isEmpty) {
                      return SizedBox(
                        height: MediaQuery.sizeOf(context).height / 3.2,
                        child: const Center(
                          child: Text(
                            'No Task For today',
                            style: TextStyle(
                              color: lightGrey,
                              fontSize: 19,
                            ),
                          ),
                        ),
                      );
                    }
                    if (state is TaskChangedState) {
                      return Center(
                        child: SizedBox(
                          width: MediaQuery.sizeOf(context).width/1.2,
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: getTodayTasks(tasksData).length - (getTodayTasks(tasksData).length / 2).round(),
                            itemBuilder: (context, index) {
                              List<Task> todayTasksVar = getTodayTasks(tasksData);
                              Task task = todayTasksVar[index];
                              if (task.taskState != TaskStates.ongoing) {
                                return const SizedBox();
                              }
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                                    return DetailTaskPage(task: task);
                                  },));
                                },
                                child: TaskDesign(
                                  taskThemeColor: getTaskColorByState(task),
                                  task: task, widthRatio: 1,
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    }
                    return SizedBox();
                  },
                ),
              ],
            )),
      ),
    );
  }
}
