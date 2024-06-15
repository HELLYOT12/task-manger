import 'package:dalioz/blocs/task_bloc.dart';
import 'package:dalioz/constants/constents.dart';
import 'package:dalioz/database/data.dart';
import 'package:dalioz/utility/utility.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/Task.dart';
import '../pages/edit_task_page.dart';

class PopOverBodyCompleted extends StatefulWidget {
  final Task task;
  const PopOverBodyCompleted({super.key, required this.task});

  @override
  State<PopOverBodyCompleted> createState() => _PopOverBodyCompletedState();
}

class _PopOverBodyCompletedState extends State<PopOverBodyCompleted> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            children: [
              const Icon(Icons.restore_outlined),
              SizedBox(width: 10),
              GestureDetector(
                onTap: () {
                  changeTaskState(widget.task, TaskStates.ongoing);
                  context
                      .read<TaskBloc>()
                      .add(ChangeTaskStateEvent(task: widget.task));
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      duration: Duration(milliseconds: 300),
                      content: Text(
                        'Task Restored Successfully',
                        style: TextStyle(color: Colors.white),
                      )));
                  Navigator.pop(context);
                },
                child: const Text(
                  'Restore',
                  style: TextStyle(
                      color: navyBlue,
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                ),
              )
            ],
          ),
          GestureDetector(
            onTap: () {
              context.read<TaskBloc>().add(RemoveTaskEvent(task: widget.task));
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  duration: Duration(milliseconds: 300),
                  content: Text(
                    'Task Deleted Successfully',
                    style: TextStyle(color: Colors.white),
                  )));
              Navigator.pop(context);
            },
            child: Row(
              children: [
                Icon(Icons.delete_outline),
                const SizedBox(width: 10),
                Text(
                  'Delete',
                  style: TextStyle(
                      color: navyBlue,
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class PopOverBodyCanceled extends StatefulWidget {
  final Task task;
  const PopOverBodyCanceled({super.key, required this.task});

  @override
  State<PopOverBodyCanceled> createState() => _PopOverBodyCanceledState();
}

class _PopOverBodyCanceledState extends State<PopOverBodyCanceled> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            children: [
              Icon(Icons.delete_outline),
              SizedBox(width: 10),
              GestureDetector(
                onTap: () {
                  context
                      .read<TaskBloc>()
                      .add(RemoveTaskEvent(task: widget.task));
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      duration: Duration(milliseconds: 300),
                      content: Text(
                        'Task Deleted Successfully',
                        style: TextStyle(color: Colors.white),
                      )));
                  Navigator.pop(context);
                },
                child: const Text(
                  'Delete',
                  style: TextStyle(
                      color: navyBlue,
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                ),
              )
            ],
          ),
          GestureDetector(
            onTap: () {
              changeTaskState(widget.task, TaskStates.ongoing);
              context
                  .read<TaskBloc>()
                  .add(ChangeTaskStateEvent(task: widget.task));
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  duration: Duration(milliseconds: 300),
                  content: Text(
                    'Task Restored Successfully',
                    style: TextStyle(color: Colors.white),
                  )));
              Navigator.pop(context);
            },
            child: Row(
              children: [
                Icon(Icons.restore_outlined),
                const SizedBox(width: 10),
                Text(
                  'Restore',
                  style: TextStyle(
                      color: navyBlue,
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class PopOverBodyPending extends StatefulWidget {
  final Task task;
  const PopOverBodyPending({super.key, required this.task});

  @override
  State<PopOverBodyPending> createState() => _PopOverBodyPendingState();
}

class _PopOverBodyPendingState extends State<PopOverBodyPending> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(Icons.check_circle_outline),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: () {
                  changeTaskState(widget.task, TaskStates.ongoing);
                  context
                      .read<TaskBloc>()
                      .add(ChangeTaskStateEvent(task: widget.task));
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      duration: Duration(milliseconds: 300),
                      content: Text(
                        'Task Enable Successfully',
                        style: TextStyle(color: Colors.white),
                      )));
                  Navigator.pop(context);
                },
                child: const Text(
                  'Enable',
                  style: TextStyle(
                      color: navyBlue,
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                ),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return EditTaskPage(
                    task: widget.task,
                  );
                },
              ));
            },
            child: Row(
              children: [
                Image.asset(
                  'lib/assets/icons/Edit-Square.png',
                ),
                SizedBox(width: 10),
                Text(
                  'Edit',
                  style: TextStyle(
                      color: navyBlue,
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                )
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () {
              changeTaskState(widget.task, TaskStates.canceled);
              context
                  .read<TaskBloc>()
                  .add(ChangeTaskStateEvent(task: widget.task));
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  duration: Duration(milliseconds: 300),
                  content: Text(
                    'Task Canceled Successfully',
                    style: TextStyle(color: Colors.white),
                  )));
              Navigator.pop(context);
            },
            child: Row(
              children: [
                Image.asset('lib/assets/icons/Delete.png'),
                SizedBox(width: 10),
                Text(
                  'Canceled',
                  style: TextStyle(
                      color: navyBlue,
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class PopOverBodyOngoing extends StatefulWidget {
  final Task task;
  const PopOverBodyOngoing({super.key, required this.task});

  @override
  State<PopOverBodyOngoing> createState() => _PopOverBodyOngoingState();
}

class _PopOverBodyOngoingState extends State<PopOverBodyOngoing> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Row(
            children: [
              Image.asset('lib/assets/icons/Close-Square-black.png'),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: () {
                  changeTaskState(widget.task, TaskStates.pending);
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      duration: Duration(milliseconds: 300),
                      content: Text(
                        'Task Disabled Successfully',
                        style: TextStyle(color: Colors.white),
                      )));
                  context
                      .read<TaskBloc>()
                      .add(ChangeTaskStateEvent(task: widget.task));
                  Navigator.pop(context);
                },
                child: const Text(
                  'Disable',
                  style: TextStyle(
                      color: navyBlue,
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return EditTaskPage(
                    task: widget.task,
                  );
                },
              ));
            },
            child: Row(
              children: [
                Icon(Icons.edit_off_outlined),
                SizedBox(width: 10),
                // TODO: EDIT LAST THING
                Text(
                  'Edit',
                  style: TextStyle(
                      color: navyBlue,
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                )
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Icon(Icons.cancel_outlined),
              SizedBox(width: 10),
              GestureDetector(
                onTap: () {
                  changeTaskState(widget.task, TaskStates.canceled);
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      duration: Duration(milliseconds: 300),
                      content: Text(
                        'Task Canceled Successfully',
                        style: TextStyle(color: Colors.white),
                      )));
                  context
                      .read<TaskBloc>()
                      .add(ChangeTaskStateEvent(task: widget.task));
                  Navigator.pop(context);
                },
                child: const Text(
                  'Canceled',
                  style: TextStyle(
                      color: navyBlue,
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
