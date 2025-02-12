import 'package:flutter/material.dart';
import '../models/task.dart';
import 'task_item.dart';

class TaskList extends StatelessWidget {
  final List<Task> tasks;
  final Function(int) onToggleComplete;
  final Function(int) onDeleteTask;

  const TaskList(
      {required this.tasks,
      required this.onToggleComplete,
      required this.onDeleteTask});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        return TaskItem(
          task: tasks[index],
          onToggleComplete: () => onToggleComplete(index),
          onDeleteTask: () => onDeleteTask(index),
        );
      },
    );
  }
}
