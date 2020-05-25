import 'package:flutter/material.dart';

import '../model/task.dart';
import '../provider/task_data.dart';

class TaskList extends StatefulWidget {
  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  List<Task> tasks = TaskData().task;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: ListView.builder(
            itemCount: TaskData().task.length,
            itemBuilder: (context, index) {
              return CheckboxListTile(
                  controlAffinity: ListTileControlAffinity.leading,
                  title: Text(tasks[index].taskName),
                  subtitle: Text(tasks[index].taskSubDescription),
                  value: tasks[index].complete,
                  onChanged: (value) {
                    setState(() {
                      tasks[index].complete = value;
                    });
                  });
            }),
      ),
    );
  }
}
