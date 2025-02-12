import 'package:flutter/material.dart';
import '../models/task.dart';

class TaskForm extends StatefulWidget {
  final Function(Task) onAddTask;
  final List<String> categories;

  const TaskForm({required this.onAddTask, required this.categories});

  @override
  _TaskFormState createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  final TextEditingController _taskController = TextEditingController();
  String _selectedCategory = 'Покупки';
  DateTime? _selectedDeadline;

  Future<void> _selectDeadline(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _selectedDeadline = picked;
      });
    }
  }

  void _submitTask() {
    if (_taskController.text.isNotEmpty) {
      widget.onAddTask(Task(
        title: _taskController.text,
        category: _selectedCategory,
        deadline: _selectedDeadline,
      ));
      _taskController.clear();
      setState(() {
        _selectedDeadline = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _taskController,
                  decoration: const InputDecoration(labelText: 'Новая задача'),
                ),
              ),
              DropdownButton<String>(
                value: _selectedCategory,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedCategory = newValue!;
                  });
                },
                items: widget.categories
                    .sublist(1)
                    .map<DropdownMenuItem<String>>((String category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
              ),
              IconButton(icon: const Icon(Icons.add), onPressed: _submitTask),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _selectedDeadline == null
                    ? 'Дедлайн: не выбран'
                    : 'Дедлайн: ${_selectedDeadline!.day}.${_selectedDeadline!.month}.${_selectedDeadline!.year}',
              ),
              TextButton(
                onPressed: () => _selectDeadline(context),
                child: const Text('Выбрать дату'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
