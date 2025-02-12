import 'package:flutter/material.dart';
import '../models/task.dart';
import '../widgets/task_form.dart';
import '../widgets/task_list.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Task> tasks = [
    Task(title: 'Купить молоко', category: 'Покупки'),
    Task(title: 'Встреча с другом', category: 'Встречи'),
    Task(title: 'Закончить проект', category: 'Работа'),
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

  void _toggleTaskCompletion(int index) {
    setState(() {
      tasks[index].isCompleted = !tasks[index].isCompleted;
    });
  }

  void _deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
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
            items: categories.map<DropdownMenuItem<String>>((String category) {
              return DropdownMenuItem<String>(
                value: category,
                child: Text(category),
              );
            }).toList(),
          ),
        ],
      ),
      body: Column(
        children: [
          TaskForm(onAddTask: _addTask, categories: categories),
          Expanded(
            child: TaskList(
              tasks: filteredTasks,
              onToggleComplete: _toggleTaskCompletion,
              onDeleteTask: _deleteTask,
            ),
          ),
        ],
      ),
    );
  }
}
