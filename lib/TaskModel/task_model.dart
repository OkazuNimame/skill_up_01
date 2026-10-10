import 'package:flutter/cupertino.dart';

class TaskModel {
  String title;
  bool check;
  int priority;
  UniqueKey id;
  TaskModel({
    required this.id,
    required this.title,
    required this.check,
    required this.priority
});
}