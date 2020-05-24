class TaskData {
  List<String> _tasks = [
    'Buy dog food',
    'Pay bills',
    'Buy hand sanitizer',
    'Buy dog food',
    'Pay bills',
  ];

  List<String> get task {
    return [..._tasks];
  }
}
