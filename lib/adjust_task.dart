import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skill_up_01/TaskModel/task_model.dart';
import 'package:skill_up_01/TaskViewModel/task_view_model.dart';

import 'main.dart';

class AdjustTask extends StatefulWidget {
  String title;
  int priority;
  bool check;
  UniqueKey uniqueKey;

  AdjustTask({
    required this.title,
    required this.priority,
    required this.uniqueKey,
    required this.check,
  });

  @override
  State<StatefulWidget> createState() {
    return _Adjust();
  }
}

class _Adjust extends State<AdjustTask> {
  late TextEditingController _title;
  late int? _selected;
  late bool _check;
  List<String> tags = Datas.tags;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _title = TextEditingController(text: widget.title);
    _selected = widget.priority;
    _check = widget.check;
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TaskViewModel>(context);
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: SafeArea(
          child: Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: _title,
                  decoration: InputDecoration(
                    label: Text("Task Title"),
                    suffixIcon: Checkbox(
                      value: _check,
                      onChanged: (value) {
                        setState(() {
                          _check = value!;
                        });
                      },
                    ),
                  ),
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
                    if (_title.text.trim().isNotEmpty) {
                      if (_selected != null) {

                        provider.updateTask(
                          TaskModel(
                            id: widget.uniqueKey,
                            title: _title.text,
                            check: _check,
                            priority: _selected!,
                          ),
                          widget.uniqueKey,
                        );
                        _title.clear();
                        _selected = null;
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MyHomePage()),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("タスクを追加できません。\n優先度を選択してください。"),
                          ),
                        );
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("タスクを追加できません。\n文字列が見当たりませんでした。"),
                        ),
                      );
                    }
                  },
                  child: Text("Add Task"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
