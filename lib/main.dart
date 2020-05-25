import 'package:done_todolist/widget/task_list.dart';
import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Color.fromRGBO(102, 153, 255, 1),
          foregroundColor: Colors.white,
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
                  Color.fromRGBO(102, 153, 255, 1),
                  Color.fromRGBO(255, 255, 255, 1),
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
              Text(
                formatDate(DateTime.now(), [dd, '-', mm]),
                style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                textAlign: TextAlign.start,
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
              Text(
                'Completed',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              TaskList(),
            ],
          ),
        ),
      ]),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(top: 190, right: 20),
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
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
    );
  }
}
