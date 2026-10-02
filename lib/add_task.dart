import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:skill_up_01/main.dart';
import 'package:skill_up_01/task_model.dart';

class AddTask extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _task();
  }
}

class _task extends State<AddTask> {
  @override
  Widget build(BuildContext context) {
    TextEditingController _taskTitle = TextEditingController();
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _taskTitle,
              decoration: InputDecoration(label: Text("Task Title")),
            ),

            ElevatedButton(
              onPressed: () {
                if (_taskTitle.text
                    .trim()
                    .isNotEmpty) {
                  Datas.datas.add(
                    TaskModel(title: _taskTitle.text, check: false),
                  );

                  _taskTitle.clear();
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyHomePage()),
                  );

                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                          "タスクを追加できません。\n文字列が見当たりませんでした。")));

                  setState(() {
                    _taskTitle.clear();
                  });
                }
              },
              child: Text("Add Task"),
            ),
          ],
        ),
      ),
    );
  }
}
