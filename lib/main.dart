import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:done_todolist/provider/task_data.dart';
import 'package:done_todolist/screen/task_page.dart';

void main() {
  // Provide the model to all widgets within the app. We're using
  // ChangeNotifierProvider because that's a simple way to rebuild
  // widgets when a model changes.
  runApp(ChangeNotifierProvider(
    create: (context) => TaskData(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //this is necessary to build the list from DB in the beginning of the app
    var runner = Provider.of<TaskData>(context, listen: false);
    runner.getFromDB();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: TextTheme(),
        primaryColor: Color.fromRGBO(93, 120, 216, 1),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Color.fromRGBO(93, 120, 216, 1),
          foregroundColor: Colors.white,
        ),
      ),
      home: TaskPage(),
    );
  }
}
