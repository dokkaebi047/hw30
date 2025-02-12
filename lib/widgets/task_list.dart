import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hw30/widgets/task_form.dart';
import '../models/task.dart';

class TaskList extends StatelessWidget {
  final List<Task> tasks;
  final Function(int, Task) onEdit;
  final Function(int) onDelete;

  const TaskList(
      {super.key,
      required this.tasks,
      required this.onEdit,
      required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        return Slidable(
          endActionPane: ActionPane(
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                onPressed: (_) => _showEditDialog(context, index),
                icon: Icons.edit,
                label: 'Редактировать',
              ),
              SlidableAction(
                onPressed: (_) => onDelete(index),
                icon: Icons.delete,
                label: 'Удалить',
              ),
            ],
          ),
          child: ListTile(
            title: Text(tasks[index].title),
            subtitle: Text(tasks[index].deadline != null
                ? 'Дедлайн: ${tasks[index].deadline!.toLocal()}'.split(' ')[0]
                : 'Дедлайн: не задан'),
          ),
        );
      },
    );
  }

  void _showEditDialog(BuildContext context, int index) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return TaskForm(
          existingTask: tasks[index],
          onSubmit: (updatedTask) => onEdit(index, updatedTask),
        );
      },
    );
  }
}
