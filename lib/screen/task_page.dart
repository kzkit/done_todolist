import 'package:flutter/material.dart';
import 'package:done_todolist/widget/task_list.dart';
import 'package:date_format/date_format.dart';

class TaskPage extends StatefulWidget {
  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(children: <Widget>[
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Color.fromRGBO(93, 120, 216, 1),
                  Color.fromRGBO(230, 244, 241, 1),
                ]),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 50,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  formatDate(DateTime.now(), [dd, '-', mm, '-', yyyy]),
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.start,
                ),
              ),
              Text('5 incomplete, 5 completed'),
              Divider(
                thickness: 2,
              ),
              Text(
                'Incomplete',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              TaskList(),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Completed',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    FlatButton.icon(
                        onPressed: () {},
                        icon: Icon(Icons.clear),
                        label: Text('Clear All'))
                  ]),
              TaskList(),
            ],
          ),
        ),
      ]),
      floatingActionButton: Padding(
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
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
