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
  int? _selected;
  List<String> tags = Datas.tags;
  TextEditingController _taskTitle = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;


    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _taskTitle,
              decoration: InputDecoration(label: Text("Task Title")),
            ),

            SizedBox(height: height * 0.05),

            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(_selected != null ? tags[_selected!] : "優先度を決めてください"),
                Wrap(
                  children: List.generate(tags.length, (index) {
                    return InputChip(
                      selected: _selected == index ? true : false,
                      label: Text(tags[index]),
                      selectedColor: Colors.green.shade100,
                      checkmarkColor: Colors.blue,
                      onSelected: (value) {
                        setState(() {
                          _selected = value ? index : null;
                        });
                      },
                    );
                  }),
                ),
              ],
            ),

            ElevatedButton(
              onPressed: () {
                if (_taskTitle.text.trim().isNotEmpty) {
                  if (_selected != null) {
                    Datas.datas.add(
                      TaskModel(
                        title: _taskTitle.text,
                        check: false,
                        priority: _selected!,
                      ),
                    );

                    _taskTitle.clear();
                    _selected = null;
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyHomePage()),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("タスクを追加できません。\n優先度を選択してください。")),
                    );
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("タスクを追加できません。\n文字列が見当たりませんでした。")),
                  );
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
