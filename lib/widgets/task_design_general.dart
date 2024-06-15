import 'package:dalioz/pages/detail_task_page.dart';
import 'package:dalioz/utility/utility.dart';
import 'package:dalioz/widgets/popover_task_body.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:popover/popover.dart';
import '../constants/constents.dart';
import '../models/Task.dart';

class TaskDesignGeneral extends StatelessWidget {
  final Task task;
  final Color taskThemeColor;
  final Color taskColor;
  final  Widget menuBody;
  const TaskDesignGeneral({super.key, required this.taskThemeColor, required this.taskColor, required this.task, required this.menuBody});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return DetailTaskPage(task: task);
        },));
      },
      child: Container(
        margin: const EdgeInsets.only(top: 10, bottom: 10,right: 10),
        padding: const EdgeInsets.only(top: 10, left: 10, bottom: 10),
        height: MediaQuery.sizeOf(context).height / 8,
        width: MediaQuery.sizeOf(context).width/1.6,
        decoration: BoxDecoration(
            color:  taskColor,
            borderRadius: BorderRadius.circular(14)),
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                    height: 50,
                    child: VerticalDivider(
                      thickness: 2,
                      color: taskThemeColor,
                    )),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width / 1.8,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                           Text(
                            task.title,
                            style: const TextStyle(
                                fontSize: 16,
                                fontFamily: 'Roboto-Medium',
                                fontWeight: FontWeight.w500,
                                color: navyBlue),
                          ),
                          GestureDetector(
                            onTap: () {
                              showPopover(
                                arrowWidth: 0,
                                arrowHeight: 10,
                                transition: PopoverTransition.other,
                                height: 120,
                                width: 150,
                                radius: 14,
                                context: context, bodyBuilder: (context) {
                                return   menuBody;
                              },);                            },
                            child: Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Image.asset(
                                'lib/assets/icons/show-more.png',width: 30,height: 25,
                                color: navyBlue,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                     Text(
                      formatTime(task.time),
                      style: const TextStyle(
                        color: lightGrey,
                      ),
                    )
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 20,
                ),
                  for (int i=0; i<task.tags.length.bitLength; i++)
                  Container(
                  margin: const EdgeInsets.only(right: 8),
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: taskThemeColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    task.tags[i].name,
                    style: TextStyle(fontSize: 10, color: taskThemeColor),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
