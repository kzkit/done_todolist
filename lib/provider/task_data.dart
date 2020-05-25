import 'package:done_todolist/model/task.dart';
import 'package:flutter/material.dart';

class TaskData with ChangeNotifier {
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

  List<Task> get getIncompleteTask {
    return [..._tasks.where((element) => element.complete == false)];
  }

  List<Task> get getCompleteTask {
    return [..._tasks.where((element) => element.complete == true)];
  }

  void doneChecker(bool taskDone, int index) {
    //identified problem... need an unique ID
    print(index);
    print(taskDone);
    if (index != null) {
      _tasks[index].complete = taskDone;
      notifyListeners();
    }
  }
}
