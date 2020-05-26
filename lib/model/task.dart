import 'package:flutter/material.dart';

class Task {
  final String id;
  final String taskName;
  final String taskSubDescription;
  bool complete;

  Task({
    @required this.id,
    @required this.taskName,
    @required this.taskSubDescription,
    @required this.complete,
  });
}
