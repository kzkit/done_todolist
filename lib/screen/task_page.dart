import 'package:done_todolist/widget/fab.dart';
import 'package:provider/provider.dart';
import '../provider/task_data.dart';
import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';

class TaskPage extends StatefulWidget {
  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskData>(builder: (context, taskData, child) {
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
                    style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
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
                Expanded(
                    //If there is no AppBar, ListView will auto add padding at the top
                    //so this is to negate the padding
                    child: MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: ListView.builder(
                      itemCount: taskData.getIncompleteTask.length,
                      itemBuilder: (context, index) {
                        return CheckboxListTile(
                          controlAffinity: ListTileControlAffinity.leading,
                          title:
                              Text(taskData.getIncompleteTask[index].taskName),
                          subtitle: Text(taskData
                              .getIncompleteTask[index].taskSubDescription),
                          value: taskData.getIncompleteTask[index].complete,
                          onChanged: (value) =>
                              taskData.doneChecker(value, index),
                        );
                      }),
                )),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Completed',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      FlatButton.icon(
                          onPressed: () {},
                          icon: Icon(Icons.clear),
                          label: Text('Clear All'))
                    ]),
                Expanded(
                  //If there is no AppBar, ListView will auto add padding at the top
                  //so this is to negate the padding
                  child: MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: ListView.builder(
                        itemCount: taskData.getCompleteTask.length,
                        itemBuilder: (context, index) {
                          return CheckboxListTile(
                            controlAffinity: ListTileControlAffinity.leading,
                            title:
                                Text(taskData.getCompleteTask[index].taskName),
                            subtitle: Text(taskData
                                .getCompleteTask[index].taskSubDescription),
                            value: taskData.getCompleteTask[index].complete,
                            onChanged: (value) =>
                                taskData.doneChecker(value, index),
                          );
                        }),
                  ),
                )
              ],
            ),
          ),
        ]),
        floatingActionButton: FAB(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      );
    });
  }
}
