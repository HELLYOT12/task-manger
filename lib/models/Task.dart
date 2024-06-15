import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:uuid/uuid.dart';

class Task {
  String id;
  String title;
  String des;
  DateTime date;
  Time time;
  TaskType taskType;
  List<Tag> tags;
  TaskStates taskState;
  Task(
      {required this.title,
        required this.des,
      required this.date,
      required this.time,
      required this.taskType,
      required this.tags})
      : taskState = TaskStates.ongoing, id =const Uuid().v4();
}

enum TaskStates {
  completed,
  canceled,
  pending,
  ongoing,
}

enum TaskType {
  personal,
  private,
  work,
  meeting,
  event,
}

enum Tag { office, home, urgent,health, social, fun, important, fitness, shopping, creative, planning, hobby, relaxation,}
