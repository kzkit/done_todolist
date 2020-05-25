import 'package:flutter/material.dart';

class Task {
  final String taskName;
  final String taskSubDescription;
  bool complete;

  Task({
    @required this.taskName,
    @required this.taskSubDescription,
    @required this.complete,
  });
}
