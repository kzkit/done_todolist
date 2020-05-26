import 'package:done_todolist/model/task.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';

class TaskData with ChangeNotifier {
  List<Task> _tasks = [];

  List<Task> get getIncompleteTask {
    return [..._tasks.where((element) => element.complete == false)];
  }

  List<Task> get getCompleteTask {
    return [..._tasks.where((element) => element.complete == true)];
  }

  void getFromDB() async {
    await Hive.initFlutter();
    var taskBox = await Hive.openBox('taskBox');
    print(taskBox.length);
    for (int i = 0; i < taskBox.length; i++) {
      //clear the list to avoid duplication
      if (_tasks.length <= 0) {
        _tasks = [];
      }
      var taskItem = taskBox.getAt(i);
      print(_tasks.length);
      //some reason this is duplicating. check
      var abc = _tasks.any((element) => element.id != taskItem['id']);
      print(abc);
      if (_tasks.any((element) => element.id != taskItem['id']) ||
          _tasks.length == 0) {
        _tasks.add(Task(
          id: taskItem['id'],
          taskName: taskItem['taskName'],
          taskSubDescription: taskItem['taskSubDescription'],
          complete: taskItem['complete'],
        ));
      }
    }

    notifyListeners();
  }

  void doneChecker(bool taskDone, String id) async {
    if (id != null || id != '') {
      _tasks.firstWhere((element) => element.id == id).complete = taskDone;
      var taskBox = await Hive.openBox('taskBox');
      var taskItem = taskBox.get(id);
      taskItem['complete'] = taskDone;
      taskBox.put(id, {
        'id': taskItem['id'],
        'taskName': taskItem['taskName'],
        'taskSubDescription': taskItem['taskSubDescription'],
        'complete': taskItem['complete'],
      });
      notifyListeners();
    }
  }

  void addTask(String task, String subTask) async {
    if (task == null || subTask == null) {
      return;
    }
    var uuid = new Uuid();
    var newTask = Task(
      id: uuid.v1(),
      complete: false,
      taskName: task.trim(),
      taskSubDescription: subTask.trim(),
    );
    _tasks.add(newTask);
    var taskBox = await Hive.openBox('taskBox');
    await taskBox.put(newTask.id, {
      'id': newTask.id,
      'taskName': newTask.taskName,
      'taskSubDescription': newTask.taskSubDescription,
      'complete': newTask.complete,
    });
    notifyListeners();
  }

  void deleteTask() async {
    var toRemove = [];
    var taskBox = await Hive.openBox('taskBox');
    _tasks.forEach((element) {
      if (element.complete == true) {
        toRemove.add(element.id);
      }
    });
    _tasks.removeWhere((element) => toRemove.contains(element.id));
    toRemove.forEach((id) {
      taskBox.delete(id);
    });
    notifyListeners();
  }
}
