import 'package:dalioz/constants/constents.dart';
import 'package:dalioz/models/Task.dart';
import 'package:dalioz/utility/utility.dart';
import 'package:dalioz/widgets/custom_searchbar.dart';
import 'package:dalioz/widgets/task_design.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/widgets.dart';

import '../../database/data.dart';

class CustomCategoryTypeItem extends StatefulWidget {
  final String pageTitle;
  final TaskType type;
  const CustomCategoryTypeItem({super.key, required this.pageTitle, required this.type});

  @override
  State<CustomCategoryTypeItem> createState() => _CustomCategoryTypeItemState();
}

class _CustomCategoryTypeItemState extends State<CustomCategoryTypeItem> {
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
                widget.pageTitle,
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
                    if (task.taskType == widget.type)
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: TaskDesign(
                        taskThemeColor: getTaskColorByState(task),
                        task: task, widthRatio: 1.1,
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
