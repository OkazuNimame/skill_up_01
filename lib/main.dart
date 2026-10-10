import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skill_up_01/TaskViewModel/task_view_model.dart';
import 'package:skill_up_01/add_task.dart';
import 'package:skill_up_01/adjust_task.dart';
import 'package:skill_up_01/TaskModel/task_model.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => TaskViewModel(),
      child: MyApp(),
    ),
  );
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
  bool _deleteSwitch = false;
  late List<TaskModel> datas;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    datas = Provider.of<TaskViewModel>(context).getTasks();
  }
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TaskViewModel>(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              setState(() {
                if (_deleteSwitch) {
                  _deleteSwitch = false;
                } else {
                  _deleteSwitch = true;
                }
              });
            },
            icon: Icon(Icons.delete),
          ),
          automaticallyImplyLeading: false,
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  datas = provider.getTasks();
                });
              },
              child: Text("すべて"),
            ),

            Text("|"),

            TextButton(
              onPressed: () {
                var data = provider.onlyCheckIsFalse();
                setState(() {
                  datas = data;
                });
              },
              child: Text("未完了"),
            ),

            Text("|"),

            TextButton(
              onPressed: () {
                var data = provider.onlyCheckIsTrue();
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
                            _deleteSwitch = false;
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AdjustTask(
                                  title: task.title,
                                  priority: task.priority,
                                  uniqueKey: task.id,
                                  check: task.check,
                                ),
                              ),
                            );
                          },
                          trailing: _deleteSwitch == false
                              ? Checkbox(
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
                                )
                              : IconButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      barrierDismissible: true,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text('確認'),
                                          content: const Text(
                                            'このデータを削除してもよろしいですか？',
                                          ),
                                          actions: <Widget>[
                                            TextButton(
                                              child: const Text('キャンセル'),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                            ),
                                            TextButton(
                                              child: const Text('OK'),
                                              onPressed: () {

                                                setState(() {
                                                  provider.deleteTask(task.id);
                                                });
                                                Navigator.pop(context);
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  icon: Icon(Icons.delete_outline),
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
                        "全タスク：${datas.length}個\n"
                        "完了タスク：${datas.where((e) => e.check).length}個\n"
                        "未完了タスク：${datas.where((e) => e.check == false).length}個",
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
  static List<String> tags = ["🔴高", "🟡中", "🟢低"];
}
