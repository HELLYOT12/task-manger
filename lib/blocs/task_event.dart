part of 'task_bloc.dart';

@immutable
abstract class TaskEvent {}

class EditTaskEvent extends TaskEvent {
  final Task task;

  EditTaskEvent({required this.task});
}

class AddTaskEvent extends TaskEvent {
  final Task task;

  AddTaskEvent({required this.task});
}

class RemoveTaskEvent extends TaskEvent {
  final Task task;
  RemoveTaskEvent({required this.task});
}

class ChangeTaskStateEvent extends TaskEvent {
  final Task task;

  ChangeTaskStateEvent({required this.task});
}
