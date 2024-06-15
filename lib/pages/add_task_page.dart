import 'package:dalioz/blocs/task_bloc.dart';
import 'package:dalioz/pages/root_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:dalioz/widgets/custom_button.dart';
import 'package:dalioz/widgets/custom_textField.dart';

import '../models/Task.dart';
import '../utility/utility.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  TextEditingController _controllerTitle = TextEditingController();
  TextEditingController _controllerDate = TextEditingController();
  TextEditingController _controllerTime = TextEditingController();
  TextEditingController _controllerDes = TextEditingController();

  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  TaskType? selectedTaskType;
  List<TaskType> taskTypes = TaskType.values;
  List<Tag> selectedTags = [];

  @override
  void dispose() {
    _controllerTitle.dispose();
    _controllerDate.dispose();
    _controllerTime.dispose();
    _controllerDes.dispose();
    super.dispose();
  }

  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        _controllerDate.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

  void _selectTime(BuildContext context) async {
    Navigator.of(context).push(
      showPicker(
        context: context,
        value: Time(hour: selectedTime.hour, minute: selectedTime.minute),
        onChange: (Time newValue) {
          setState(() {
            selectedTime =
                TimeOfDay(hour: newValue.hour, minute: newValue.minute);
            _controllerTime.text = selectedTime.format(context);
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Title',
                style: TextStyle(fontSize: 14, color: Color(0xff8A8BB3)),
              ),
              CustomTextField(
                controller: _controllerTitle,
                hintText: 'Plan for a month',
              ),
              const SizedBox(height: 20),
              const Text(
                'Date',
                style: TextStyle(fontSize: 14, color: Color(0xff8A8BB3)),
              ),
              GestureDetector(
                onTap: () => _selectDate(context),
                child: TextField(
                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.calendar_today),
                    hintText: 'Select Date',
                  ),
                  controller: _controllerDate,
                  enabled: false,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Time',
                style: TextStyle(fontSize: 14, color: Color(0xff8A8BB3)),
              ),
              GestureDetector(
                onTap: () => _selectTime(context),
                child: TextField(
                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.access_time),
                    hintText: 'Select Time',
                  ),
                  controller: _controllerTime,
                  enabled: false,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Description',
                style: TextStyle(fontSize: 14, color: Color(0xff8A8BB3)),
              ),
              CustomTextField(
                controller: _controllerDes,
                hintText: 'Enter description',
              ),
              const SizedBox(height: 20),
              const Text(
                'Type',
                style: TextStyle(fontSize: 14, color: Color(0xff8A8BB3)),
              ),
              Column(
                children: taskTypes.map((taskType) {
                  return RadioListTile<TaskType>(
                    title: Text(taskType.name),
                    value: taskType,
                    groupValue: selectedTaskType,
                    onChanged: (TaskType? value) {
                      setState(() {
                        selectedTaskType = value;
                      });
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              const Text(
                'Tags',
                style: TextStyle(fontSize: 14, color: Color(0xff8A8BB3)),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8.0,
                runSpacing: 4.0,
                children: Tag.values.map((tag) {
                  return _buildTag(tag);
                }).toList(),
              ),
              const SizedBox(height: 40),
              CustomButton(
                  onTap: () {
                    final title = _controllerTitle.text.trim();
                    final description = _controllerDes.text.trim();
                    DateTime? date = selectedDate;
                    Time? time = Time(
                        hour: selectedTime.hour, minute: selectedTime.minute);
                    if (title.isEmpty ||
                        description.isEmpty ||
                        time == null ||
                        date == null ||
                        selectedTaskType == null ||
                        selectedTags.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              'Please fill out all fields and select a type and at least one tag.'),
                        ),
                      );
                      return;
                    }
                    Task task = Task(
                        title: _controllerTitle.text.trim(),
                        date: selectedDate,
                        time: time,
                        taskType: selectedTaskType!,
                        tags: selectedTags,
                        des: description);
                    context.read<TaskBloc>().add(AddTaskEvent(task: task));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Task Add Successfully'),
                      ),
                    );
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                      builder: (context) {
                        return const RootPage();
                      },
                    ), (route) => false);
                  },
                  title: 'Create'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTag(Tag tag) {
    final isSelected = selectedTags.contains(tag);
    final color = getTagColor(tag);
    return GestureDetector(
      onTap: () {
        setState(() {
          if (isSelected) {
            selectedTags.remove(tag);
          } else {
            selectedTags.add(tag);
          }
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        decoration: BoxDecoration(
          color: isSelected ? color : color.withOpacity(0.2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          tag.name,
          style: TextStyle(
            fontSize: 14,
            color: isSelected ? Colors.white : color,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
