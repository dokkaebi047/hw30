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

  String get formattedDeadline {
    if (deadline == null) return 'не задан';

    return '${deadline!.day.toString().padLeft(2, '0')}.'
        '${deadline!.month.toString().padLeft(2, '0')}.'
        '${deadline!.year}';
  }
}
