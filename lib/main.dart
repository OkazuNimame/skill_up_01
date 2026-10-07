import 'package:flutter/material.dart';
import 'package:skill_up_01/add_task.dart';
import 'package:skill_up_01/adjust_task.dart';
import 'package:skill_up_01/task_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SkillUp_01',
      theme: ThemeData(),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage> {
  late List<TaskModel> datas;

  @override
  void initState() {
    super.initState();
    datas = Datas.datas;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  datas = Datas.datas;
                });
              },
              child: Text("すべて"),
            ),

            TextButton(
              onPressed: () {
                var data = Datas.datas.where((e) => e.check == false).toList();
                setState(() {
                  datas = data;
                });
              },
              child: Text("未完了"),
            ),

            TextButton(
              onPressed: () {
                var data = Datas.datas.where((e) => e.check == true).toList();
                setState(() {
                  datas = data;
                });
              },
              child: Text("完了"),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddTask()),
            );
          },
          child: Icon(Icons.add),
        ),
        body: datas.isNotEmpty
            ? Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.6,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                      itemCount: datas.length,
                      itemBuilder: (context, index) {
                        final task = datas[index];
                        return ListTile(
                          title: Text(
                            "${task.title} 重要度:${Datas.tags[task.priority]}",
                          ),
                          subtitle: task.check ? Text("完了！") : Text("未完了"),
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AdjustTask(
                                  title: task.title,
                                  priority: task.priority,
                                  index: index,
                                ),
                              ),
                            );
                          },
                          trailing: Checkbox(
                            value: task.check,
                            onChanged: (value) {
                              setState(() {
                                task.check = value!;
                                if (task.check) {
                                  var data = datas.removeAt(index);
                                  datas.insert(datas.length, data);
                                } else {
                                  var data = datas.removeAt(index);
                                  datas.insert(0, data);
                                }
                              });
                            },
                          ),
                        );
                      },
                    ),
                  ),

                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),

                  SingleChildScrollView(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "全タスク：${Datas.datas.length}個\n"
                        "完了タスク：${Datas.datas.where((e) => e.check).length}個\n"
                        "未完了タスク：${Datas.datas.where((e) => e.check == false).length}個",
                      ),
                    ),
                  ),
                ],
              )
            : Center(child: Text("タスクがありません。")),
      ),
    );
  }
}

class Datas {
  static List<TaskModel> datas = [];
  static List<String> tags = ["🔴高", "🟡中", "🟢低"];
}
