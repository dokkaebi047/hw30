import 'package:flutter/material.dart';
import '../models/task.dart';
import '../widgets/task_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Task> tasks = [
    Task(title: 'Купить молоко', category: 'Покупки'),
    Task(title: 'Встреча с другом', category: 'Встречи'),
    Task(title: 'Закончить проект', category: 'Работа'),
    Task(title: 'Прочитать книгу', category: 'Обучение'),
  ];

  final TextEditingController taskController = TextEditingController();
  String selectedCategory = 'Все задачи';
  final List<String> categories = [
    'Все задачи',
    'Покупки',
    'Встречи',
    'Работа',
    'Обучение'
  ];
  String newTaskCategory = 'Покупки';

  void _addTask() {
    if (taskController.text.isNotEmpty) {
      setState(() {
        tasks.add(Task(title: taskController.text, category: newTaskCategory));
        taskController.clear();
      });
    }
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: taskController,
                    decoration:
                        const InputDecoration(labelText: 'Новая задача'),
                  ),
                ),
                DropdownButton<String>(
                  value: newTaskCategory,
                  onChanged: (String? newValue) {
                    setState(() {
                      newTaskCategory = newValue!;
                    });
                  },
                  items: categories
                      .sublist(1)
                      .map<DropdownMenuItem<String>>((String category) {
                    return DropdownMenuItem<String>(
                      value: category,
                      child: Text(category),
                    );
                  }).toList(),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: _addTask,
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredTasks.length,
              itemBuilder: (context, index) {
                return TaskItem(
                  task: filteredTasks[index],
                  onToggle: () => _toggleTaskCompletion(index),
                  onDelete: () => _deleteTask(index),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
