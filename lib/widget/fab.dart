import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/task_data.dart';

class FAB extends StatefulWidget {
  @override
  _FABState createState() => _FABState();
}

class _FABState extends State<FAB> {
  final _formKey = GlobalKey<FormState>();
  final taskController = TextEditingController();
  final subTaskController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    taskController.dispose();
    subTaskController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final taskData = Provider.of<TaskData>(context, listen: false);
    return Padding(
      padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 20),
      child: FloatingActionButton.extended(
        onPressed: () {
          showModalBottomSheet(
            shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.vertical(top: Radius.circular(25.0))),
            isScrollControlled: true,
            context: context,
            builder: (context) => Padding(
              padding: EdgeInsets.only(
                //necessary to move the modalsheet up according to keyboard.
                bottom: MediaQuery.of(context).viewInsets.bottom + 20,
                left: MediaQuery.of(context).viewInsets.left + 20,
                right: MediaQuery.of(context).viewInsets.right + 20,
                top: 15,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    TextFormField(
                      controller: taskController,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.assignment),
                        labelText: 'Task',
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: subTaskController,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.assignment_late),
                        labelText: 'Additional Information',
                      ),
                    ),
                    SizedBox(height: 10),
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(25.0))),
                      color: Theme.of(context).primaryColor,
                      textColor: Colors.white,
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          taskData.addTask(
                              taskController.text, subTaskController.text);
                          Navigator.pop(context);
                        }
                      },
                      child: Text('Add'),
                    ),
                    SizedBox(height: 15),
                  ],
                ),
              ),
            ),
          );
        },
        tooltip: 'Add task',
        label: Text('Add Task'),
        icon: Icon(Icons.add),
        elevation: 7,
      ),
    );
  }
}
