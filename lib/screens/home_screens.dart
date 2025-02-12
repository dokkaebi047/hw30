import 'package:flutter/material.dart';
import '../models/task.dart';
import '../widgets/task_list.dart';
import '../widgets/task_form.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Task> tasks = [
    Task(
        title: 'Купить молоко',
        category: 'Покупки',
        deadline: DateTime.now().add(Duration(days: 2))),
    Task(title: 'Встреча с другом', category: 'Встречи'),
    Task(
        title: 'Закончить проект',
        category: 'Работа',
        deadline: DateTime.now().add(Duration(days: 5))),
    Task(title: 'Прочитать книгу', category: 'Обучение'),
  ];

  String selectedCategory = 'Все задачи';
  final List<String> categories = [
    'Все задачи',
    'Покупки',
    'Встречи',
    'Работа',
    'Обучение'
  ];

  void _addTask(Task task) {
    setState(() {
      tasks.add(task);
    });
  }

  void _editTask(int index, Task updatedTask) {
    setState(() {
      tasks[index] = updatedTask;
    });
  }

  void _deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    tasks.sort((a, b) {
      if (a.deadline == null && b.deadline == null)
        return a.title.compareTo(b.title);
      if (a.deadline == null) return 1;
      if (b.deadline == null) return -1;
      return a.deadline!.compareTo(b.deadline!);
    });

    List<Task> filteredTasks = selectedCategory == 'Все задачи'
        ? tasks
        : tasks.where((task) => task.category == selectedCategory).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('TODO-лист'),
        actions: [
          DropdownButton<String>(
            value: selectedCategory,
            onChanged: (String? newValue) {
              setState(() {
                selectedCategory = newValue!;
              });
            },
            items: categories.map((String category) {
              return DropdownMenuItem<String>(
                value: category,
                child: Text(category),
              );
            }).toList(),
          ),
        ],
      ),
      body: TaskList(
          tasks: filteredTasks, onEdit: _editTask, onDelete: _deleteTask),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showModalBottomSheet(
          context: context,
          builder: (context) => TaskForm(onSubmit: _addTask),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
