import 'package:flutter/material.dart';
import '../constants/constents.dart';
import '../models/Task.dart';
import '../utility/utility.dart';

class TaskDesign extends StatelessWidget {
  final Color taskThemeColor;
  final Task task;
  final double widthRatio;
  const TaskDesign(
      {super.key, required this.taskThemeColor, required this.task, required this.widthRatio});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      padding: const EdgeInsets.only(top: 10, left: 10, bottom: 10),
      height: MediaQuery.sizeOf(context).height / 8,
      width: MediaQuery.sizeOf(context).width / widthRatio,
      decoration: BoxDecoration(
          color: const Color(0xffeaeaea).withOpacity(0.3),
          borderRadius: BorderRadius.circular(14)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(
                  height: 50,
                  child: VerticalDivider(
                    thickness: 2,
                    color: taskThemeColor,
                  )),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            task.title,
                            style: const TextStyle(
                                fontSize: 16,
                                fontFamily: 'Roboto-Medium',
                                fontWeight: FontWeight.w500,
                                color: navyBlue),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Image.asset(
                            'lib/assets/icons/show-more.png',
                            color: Colors.black,
                          ),
                        )
                      ],
                    ),
                    Text(
                      formatTime(task.time),
                      style: const TextStyle(
                        color: lightGrey,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft, // Align the ListView to the start
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: task.tags.length.bitLength,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: taskThemeColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        task.tags[index].name, // Dynamically display tag
                        style: TextStyle(fontSize: 10, color: taskThemeColor),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
