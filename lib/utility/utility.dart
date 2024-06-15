// Count the time left in day
import 'dart:ui';

import 'package:dalioz/constants/constents.dart';
import 'package:dalioz/database/data.dart';
import 'package:dalioz/models/Task.dart';
import 'package:day_night_time_picker/lib/state/time.dart';
import 'package:flutter/material.dart';
import 'package:dalioz/database/data.dart';


Task  changeTaskState(Task task, TaskStates state) {
  task.taskState =  state;
  return task;
}

Color getTagColor(Tag tag) {
  switch (tag) {
    case Tag.office:
      return Color(0xff8F81FE);
    case Tag.home:
      return Color(0xffF0A58E);
    case Tag.urgent:
      return Color(0xffF57C96);
    case Tag.health:
      return Color(0xff1EC1C3);
    case Tag.social:
      return Color(0xffFF9F1C);
    case Tag.fun:
      return Color(0xffE27D60);
    case Tag.important:
      return Color(0xff2A9D8F);
    case Tag.fitness:
      return Color(0xff264653);
    case Tag.shopping:
      return Color(0xffE76F51);
    default:
      return Color(0xff8A8BB3);
  }
}


Duration timeLeftInDay() {
  DateTime now = DateTime.now();
  DateTime endOfDay = DateTime(now.year, now.month, now.day, 23, 59, 59);
  Duration difference = endOfDay.difference(now);
  return difference;
}

String getCurrentHourWithMin() {
  DateTime now = DateTime.now();
  return "${now.hour}:${now.minute}";
}

int countTaskByType(List<Task> tasks , TaskType type){
  int counter = 0;
  for (int i=0; i<tasks.length; i++) {
    if (tasks[i].taskType == type) {
      counter++;
    }
  }
  return counter;
}

String formatTime(Time time) {
  if (time.hour > 12) {
    time.hour - 12;
    String formattedTime = "${time.hour - 12}:${time.minute} PM";
    return formattedTime;
  }
  String formattedTime = "${time.hour}:${time.minute} AM";
  return formattedTime;
}

int countTaskByState(List<Task> tasks, TaskStates taskState) {
  int counter = 0;
  for (int i = 0; i < tasks.length; i++) {
    if (tasks[i].taskState == taskState) {
      counter++;
    }
  }
  return counter;
}

Color getTaskColorByState(Task task) {
  if (task.taskState == TaskStates.pending) {
    return pendingColor;
  } else if (task.taskState == TaskStates.ongoing) {
    return onGoingColor;
  } else if (task.taskState == TaskStates.canceled) {
    return canceledColor;
  } else if (task.taskState == TaskStates.completed) {
    return completedColor;
  } else {
    return Colors.white;
  }
}

String getMonthName(DateTime date) {
  // List of month names in order from January to December
  const List<String> monthNames = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  // DateTime.month returns an integer from 1 (January) to 12 (December)
  int monthIndex = date.month - 1; // Subtract 1 to convert to 0-based index

  return monthNames[monthIndex];
}

String getDayName(DateTime date) {
  // List of day names in order from Monday to Sunday
  const List<String> dayNames = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];

  // DateTime.weekday returns an integer from 1 (Monday) to 7 (Sunday)
  int dayIndex = date.weekday - 1; // Subtract 1 to convert to 0-based index

  return dayNames[dayIndex];
}

List<List<Task>> getTasksByHour(List<Task> tasks) {
  List<Task> oneToFourDay = [];
  List<Task> fiveToEightDay = [];
  List<Task> nineToTwelveDay = [];
  List<Task> oneToFourNight = [];
  List<Task> fiveToEightNight = [];
  List<Task> nineToTwelveNight = [];

  for (var task in tasks) {
    int hour = task.time.hour;

    if (hour >= 1 && hour <= 4) {
      oneToFourDay.add(task);
    } else if (hour >= 5 && hour <= 8) {
      fiveToEightDay.add(task);
    } else if (hour >= 9 && hour <= 12) {
      nineToTwelveDay.add(task);
    } else if (hour >= 13 && hour <= 16) {
      oneToFourNight.add(task);
    } else if (hour >= 17 && hour <= 20) {
      fiveToEightNight.add(task);
    } else if (hour >= 21 || hour == 0) {
      nineToTwelveNight.add(task);
    }
  }

  return [
    oneToFourDay,
    fiveToEightDay,
    nineToTwelveDay,
    oneToFourNight,
    fiveToEightNight,
    nineToTwelveNight,
  ];
}

List<Task> getTodayTasks(List<Task> tasks) {
  List<Task> todayTasks = [];
  for (int i = tasks.length-1; i > 0; i--) {
    if (tasks[i].date.day == DateTime.now().day) {
      todayTasks.add(tasks[i]);
    }
  }
  return todayTasks;
}

List<Task> getTasksByDate(List<Task> tasks, DateTime date) {
  List<Task> tasksByDate = [];
  for (var task in tasks) {
    if (task.date.year == date.year &&
        task.date.month == date.month &&
        task.date.day == date.day) {
      tasksByDate.add(task);
    }
  }
  print('Number of tasks on ${date.toLocal()}: ${tasksByDate.length}');
  return tasksByDate;
}

List<Task> getTaskByState(List<Task> tasks, TaskStates taskState) {
  List<Task> stateTasks = [];
  for (var task in tasks) {
    if (task.taskState == taskState) {
      stateTasks.add(task);
    }
  }
  return stateTasks;
}

Map<DateTime, List<Task>> groupTasksByDate(List<Task> tasks) {
  Map<DateTime, List<Task>> tasksByDate = {};

  for (var task in tasks) {
    DateTime taskDate = DateTime(task.date.year, task.date.month, task.date.day);

    if (!tasksByDate.containsKey(taskDate)) {
      tasksByDate[taskDate] = [];
    }
    // Add the task to the list for the corresponding date
    tasksByDate[taskDate]!.add(task);
  }

  return tasksByDate;
}
