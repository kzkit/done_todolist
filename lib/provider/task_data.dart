import 'package:done_todolist/model/task.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

class TaskData with ChangeNotifier {
  List<Task> _tasks = [];

  //Provider is still necessary for this project because we have to query the lists for
  //completion status... Hive does not support queries atm of development.
  List<Task> get getIncompleteTask {
    return [..._tasks.where((element) => element.complete == false)];
  }

  List<Task> get getCompleteTask {
    return [..._tasks.where((element) => element.complete == true)];
  }

  void getFromDB() async {
    var taskBox = await Hive.openBox('taskBox');
    //clear the _tasks to avoid contamination
    _tasks = [];
    for (int i = 0; i < taskBox.length; i++) {
      var taskItem = taskBox.getAt(i);
      _tasks.add(Task(
        id: taskItem['id'],
        taskName: taskItem['taskName'],
        taskSubDescription: taskItem['taskSubDescription'],
        complete: taskItem['complete'],
      ));
    }
    notifyListeners();
  }

  void doneChecker(bool taskDone, String id) async {
    if (id != null || id != '') {
      //assign the bool to the task
      _tasks.firstWhere((element) => element.id == id).complete = taskDone;
      var taskBox = await Hive.openBox('taskBox');
      var taskItem = taskBox.get(id);
      taskItem['complete'] = taskDone;
      //add back to the DB
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
    print(taskBox.length);
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
