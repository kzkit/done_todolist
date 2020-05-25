import 'package:done_todolist/model/task.dart';

class TaskData {
  List<Task> _tasks = [
    Task(
      taskName: 'Pay bills',
      taskSubDescription: 'Internet bills and rent',
      complete: true,
    ),
    Task(
      taskName: 'Buy dog food',
      taskSubDescription: 'Pedigree 10kg Grilled Steak and Vegetables',
      complete: false,
    ),
  ];

  List<Task> get task {
    return [..._tasks];
  }
}
