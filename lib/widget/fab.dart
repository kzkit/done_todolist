import 'package:flutter/material.dart';

class FAB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 40),
      child: FloatingActionButton.extended(
        onPressed: () {
          //...add task for fab
        },
        tooltip: 'Add task',
        label: Text('Add Task'),
        icon: Icon(Icons.add),
        elevation: 7,
      ),
    );
  }
}
