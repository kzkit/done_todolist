import 'package:done_todolist/widget/fab.dart';
import 'package:provider/provider.dart';
import '../provider/task_data.dart';
import 'package:hive/hive.dart';
import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';

class TaskPage extends StatefulWidget {
  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  @override
  void dispose() {
    //close the DB when state is disposed
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //this is necessary to build the list from DB in the beginning of the app
    var runner = Provider.of<TaskData>(context, listen: false);
    runner.getFromDB();
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
                Text(
                    '${taskData.getIncompleteTask.length} incomplete, ${taskData.getCompleteTask.length}  completed'),
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
                            title: Text(
                                taskData.getIncompleteTask[index].taskName),
                            //checking if subtitle has a value, if no don't display.
                            subtitle: taskData.getIncompleteTask[index]
                                        .taskSubDescription !=
                                    ''
                                ? Text(taskData.getIncompleteTask[index]
                                    .taskSubDescription)
                                : null,
                            value: taskData.getIncompleteTask[index].complete,
                            onChanged: (value) {
                              taskData.doneChecker(
                                value,
                                taskData.getIncompleteTask[index].id,
                              );
                            });
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
                      if (taskData.getCompleteTask.length != 0)
                        FlatButton.icon(
                            onPressed: () {
                              taskData.deleteTask();
                            },
                            icon: Icon(Icons.clear),
                            label: Text('Clear')),
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
                            title: Text(
                              taskData.getCompleteTask[index].taskName,
                              style: TextStyle(
                                  decoration: TextDecoration.lineThrough),
                            ),
                            //checking if subtitle has a value, if no don't display.
                            subtitle: taskData.getCompleteTask[index]
                                        .taskSubDescription !=
                                    ''
                                ? Text(
                                    taskData.getCompleteTask[index]
                                        .taskSubDescription,
                                    style: TextStyle(
                                        decoration: TextDecoration.lineThrough))
                                : null,
                            value: taskData.getCompleteTask[index].complete,
                            onChanged: (value) => taskData.doneChecker(
                              value,
                              taskData.getCompleteTask[index].id,
                            ),
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
