import 'package:flutter/material.dart';
import '../models/task.dart';

class TaskForm extends StatefulWidget {
  final Function(Task) onSubmit;
  final Task? existingTask;

  const TaskForm({super.key, required this.onSubmit, this.existingTask});

  @override
  _TaskFormState createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  final TextEditingController taskController = TextEditingController();
  String selectedCategory = 'Покупки';
  DateTime? selectedDeadline;

  @override
  void initState() {
    super.initState();
    if (widget.existingTask != null) {
      taskController.text = widget.existingTask!.title;
      selectedCategory = widget.existingTask!.category;
      selectedDeadline = widget.existingTask!.deadline;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: taskController,
            decoration: const InputDecoration(labelText: 'Название задачи'),
          ),
          DropdownButton<String>(
            value: selectedCategory,
            onChanged: (String? newValue) {
              setState(() {
                selectedCategory = newValue!;
              });
            },
            items: ['Покупки', 'Встречи', 'Работа', 'Обучение']
                .map((String category) {
              return DropdownMenuItem<String>(
                value: category,
                child: Text(category),
              );
            }).toList(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                selectedDeadline == null
                    ? 'Дедлайн: не выбран'
                    : 'Дедлайн: ${selectedDeadline!.toLocal()}'.split(' ')[0],
              ),
              TextButton(
                onPressed: () => _selectDeadline(context),
                child: const Text('Выбрать дату'),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    selectedDeadline = null;
                  });
                },
                child: const Text('Очистить'),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () {
              widget.onSubmit(Task(
                title: taskController.text,
                category: selectedCategory,
                deadline: selectedDeadline,
              ));
              Navigator.pop(context);
            },
            child: const Text('Сохранить'),
          ),
        ],
      ),
    );
  }

  Future<void> _selectDeadline(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        selectedDeadline = picked;
      });
    }
  }
}
