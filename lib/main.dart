import 'package:flutter/material.dart';
import 'package:skill_up_01/add_task.dart';
import 'package:skill_up_01/task_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
    // TODO: implement initState
    super.initState();
    datas = Datas.datas;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                      itemCount: Datas.datas.length,
                      itemBuilder: (context, index) {
                        final task = Datas.datas[index];
                        return ListTile(
                          title: Text(task.title),
                          subtitle: task.check ? Text("完了！") : Text("未完了"),
                          trailing: Checkbox(
                            value: task.check,
                            onChanged: (value) {
                              setState(() {
                                task.check = value!;
                              });
                            },
                          ),
                        );
                      },
                    ),
                  ),

                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),

                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.3,
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
  static List<TaskModel> datas = [];
}
