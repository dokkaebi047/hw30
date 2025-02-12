class Task {
  String title;
  bool isCompleted;
  String category;
  DateTime? deadline;

  Task({
    required this.title,
    this.isCompleted = false,
    required this.category,
    this.deadline,
  });

  get formattedDeadline => null;
}
