import 'package:flutter/material.dart';
import '../provider/task_data.dart';

class TaskList extends StatefulWidget {
  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  bool _isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: MediaQuery.removePadding(
        context: context,
        removeLeft: true,
        removeTop: true,
        child: ListView.builder(
            itemCount: TaskData().task.length,
            itemBuilder: (context, index) {
              return CheckboxListTile(
                  controlAffinity: ListTileControlAffinity.leading,
                  title: Text('test'),
                  value: _isChecked,
                  onChanged: (value) {
                    setState(() {
                      _isChecked = value;
                    });
                  });
            }),
      ),
    );
  }
}
