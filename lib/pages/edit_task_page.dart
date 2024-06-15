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

class EditTaskPage extends StatefulWidget {
  final Task task;
  const EditTaskPage({super.key, required this.task});

  @override
  State<EditTaskPage> createState() => _EditTaskPageState();
}

class _EditTaskPageState extends State<EditTaskPage> {
  late TextEditingController _controllerTitle;
  late TextEditingController _controllerDes;

  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  TaskType? selectedTaskType;
  List<TaskType> taskTypes = TaskType.values;
  List<Tag> selectedTags = [];

  @override
  void initState() {
    _controllerTitle = TextEditingController(text: widget.task.title);
    _controllerDes = TextEditingController(text: widget.task.des);
    selectedDate = widget.task.date;
    selectedTime = TimeOfDay(hour: widget.task.time.hour, minute: widget.task.time.minute);
    selectedTaskType = widget.task.taskType;
    selectedTags = List<Tag>.from(widget.task.tags);
    super.initState();
  }

  @override
  void dispose() {
    _controllerTitle.dispose();
    _controllerDes.dispose();
    super.dispose();
  }

  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
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
            selectedTime = TimeOfDay(hour: newValue.hour, minute: newValue.minute);
          });
        },
      ),
    );
  }

  void _saveTask(BuildContext context) {
    String title = _controllerTitle.text.trim();
    String description = _controllerDes.text.trim();
    DateTime date = selectedDate;
    Time time = Time(hour: selectedTime.hour, minute: selectedTime.minute);

    if (title.isEmpty || description.isEmpty || selectedTaskType == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill all fields'),
        ),
      );
      return;
    }
    Task editedTask = Task(
      title: title,
      date: date,
      time: time,
      taskType: selectedTaskType!,
      tags: selectedTags,
      des: description,
    );
    editedTask.id = widget.task.id; // Ensure the task ID is persisted
    editedTask.taskState = widget.task.taskState;
    context.read<TaskBloc>().add(EditTaskEvent(task: editedTask));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Task Edited Successfully'),
      ),
    );
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const RootPage()),
          (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Task'),
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
                hintText: 'Edit title',
              ),
              const SizedBox(height: 20),
              const Text(
                'Date',
                style: TextStyle(fontSize: 14, color: Color(0xff8A8BB3)),
              ),
              GestureDetector(
                onTap: () => _selectDate(context),
                child: AbsorbPointer(
                  child: TextField(
                    controller: TextEditingController(
                      text: "${selectedDate.year}/${selectedDate.month}/${selectedDate.day}",
                    ),
                    decoration: const InputDecoration(
                      suffixIcon: Icon(Icons.calendar_today),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Time',
                style: TextStyle(fontSize: 14, color: Color(0xff8A8BB3)),
              ),
              GestureDetector(
                onTap: () => _selectTime(context),
                child: AbsorbPointer(
                  child: TextField(
                    controller: TextEditingController(
                      text: "${selectedTime.format(context)}",
                    ),
                    decoration: const InputDecoration(
                      suffixIcon: Icon(Icons.access_time),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Description',
                style: TextStyle(fontSize: 14, color: Color(0xff8A8BB3)),
              ),
              CustomTextField(
                controller: _controllerDes,
                hintText: 'Edit description',
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
                onTap: () => _saveTask(context),
                title: 'Edit Task',
              ),
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
