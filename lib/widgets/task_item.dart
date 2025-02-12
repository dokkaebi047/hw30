import 'package:flutter/material.dart';
import '../models/task.dart';

class TaskItem extends StatelessWidget {
  final Task task;
  final VoidCallback onToggleComplete;
  final VoidCallback onDeleteTask;

  const TaskItem(
      {required this.task,
      required this.onToggleComplete,
      required this.onDeleteTask});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        task.title,
        style: TextStyle(
          decoration: task.isCompleted
              ? TextDecoration.lineThrough
              : TextDecoration.none,
          color: task.isCompleted ? Colors.grey : Colors.black,
        ),
      ),
      subtitle: Text(
          'Категория: ${task.category} | Дедлайн: ${task.formattedDeadline}'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(task.isCompleted
                ? Icons.check_box
                : Icons.check_box_outline_blank),
            onPressed: onToggleComplete,
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: onDeleteTask,
          ),
        ],
      ),
    );
  }
}
