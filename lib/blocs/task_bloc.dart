import 'package:bloc/bloc.dart';
import 'package:dalioz/database/data.dart';
import 'package:meta/meta.dart';
import '../models/Task.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc() : super(TaskInitial()) {

    on<EditTaskEvent>((event, emit) {
      final index = tasksData.indexWhere((task) => task.id == event.task.id);
      if (index != -1) {
        tasksData[index] = event.task;
        emit(TaskChangedState(tasks: tasksData));
      }
    });

    on<AddTaskEvent>((event, emit) {
      if (event.task.taskState == TaskStates.pending) {
        tasksData.add(event.task);
        emit(TaskChangedState(tasks: tasksData));
      }
      else if (event.task.taskState == TaskStates.canceled) {
        tasksData.add(event.task);
        emit(TaskChangedState(tasks: tasksData));
      }
      else if (event.task.taskState == TaskStates.ongoing) {
        tasksData.add(event.task);
        emit(TaskChangedState(tasks: tasksData));
      }
      else if (event.task.taskState == TaskStates.completed) {
        tasksData.add(event.task);
        emit(TaskChangedState(tasks: tasksData));
      }
    });

    on<RemoveTaskEvent>((event, emit) {
      if (event.task.taskState == TaskStates.pending) {
        tasksData.remove(event.task);
        emit(TaskChangedState(tasks: tasksData));
      }
      else if (event.task.taskState == TaskStates.canceled) {
        tasksData.remove(event.task);
        emit(TaskChangedState(tasks: tasksData));
      }
      else if (event.task.taskState == TaskStates.ongoing) {
        tasksData.remove(event.task);
        emit(TaskChangedState(tasks: tasksData));
      }
      else if (event.task.taskState == TaskStates.completed) {
        tasksData.remove(event.task);
        emit(TaskChangedState(tasks: tasksData));
      }
    });

    on<ChangeTaskStateEvent>((event, emit) {
      for (var task in tasksData) {
        if (task.id == event.task.id) {
          task.taskState = event.task.taskState;
          break;
        }
      }
      emit(TaskChangedState(tasks: tasksData));
    });
  }
}
