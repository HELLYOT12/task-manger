part of 'task_bloc.dart';

@immutable
abstract class TaskState {}

class TaskInitial extends TaskState {}

class TaskChangedState extends TaskState {
  final List<Task> tasks;

  TaskChangedState({required this.tasks});
}
