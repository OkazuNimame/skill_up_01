import 'package:flutter/cupertino.dart';
import 'package:skill_up_01/TaskModel/task_model.dart';

class TaskViewModel extends ChangeNotifier {
  List<TaskModel> tasks = [];

  List<TaskModel> getTasks() {
    return tasks;
  }

  void addTask(TaskModel task) {
    tasks.add(task);
    notifyListeners();
  }

  void updateTask(TaskModel newTask, UniqueKey key) {
    final index = tasks.indexWhere((e) => e.id == key);
    if (index != -1) {
      tasks[index] = newTask;
    }
    notifyListeners();
  }

  void deleteTask(UniqueKey key) {
    tasks.removeWhere((e) => e.id == key);
    notifyListeners();
  }

  List<TaskModel> onlyCheckIsTrue() {
    return tasks.where((e) => e.check == true).toList();
  }

  List<TaskModel> onlyCheckIsFalse() {
    return tasks.where((e) => e.check == false).toList();

  }
}
