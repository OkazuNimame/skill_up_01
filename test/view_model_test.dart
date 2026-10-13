import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:skill_up_01/TaskModel/task_model.dart';
import 'package:skill_up_01/TaskViewModel/task_view_model.dart';

import 'package:flutter_test/flutter_test.dart';

// 本物のファイルをインポートする想定
// import 'package:your_project/task_view_model.dart';

void main() {
  // group でTODOアプリのテストをまとめます
  group('TODOアプリのViewModelクラスの単体検査', () {

    test('初期化時はタスクリストの中身は何もなし', () {
      final viewModel = TaskViewModel(); // 本物のクラスを準備
      expect(viewModel.getTasks().length, 0);
    });

    test('タスク一覧データを取得するときは、変更できない変数か（エラーになるか）', () {
      final viewModel = TaskViewModel();
      var data = viewModel.getTasks(); // 本物の getTasks() を呼ぶ

      void errorCode() {
        data.add(TaskModel(id: UniqueKey(), title: "ばーか", check: true, priority: 1));
      }

      expect(errorCode, throwsUnsupportedError);
    });

    test('Taskデータを一つ追加できるかどうか', () {
      final viewModel = TaskViewModel();

      // 本物の addTask を呼ぶ
      viewModel.addTask(TaskModel(id: UniqueKey(), title: "正常なデータです", check: false, priority: 0));

      expect(viewModel.getTasks().length, 1);
    });

    test('Taskデータをupdateできるかどうか', () {
      final viewModel = TaskViewModel();
      final key = UniqueKey();
      viewModel.addTask(TaskModel(id: key, title: "テストタスク", check: false, priority: 0));

      // 本物の updateTask または toggleTask を呼ぶ
      viewModel.toggleTask(key, true);

      expect(viewModel.getTasks().first.check, true);
    });

    test('Taskデータを削除できるかどうか', () {
      final viewModel = TaskViewModel();
      final key = UniqueKey();
      viewModel.addTask(TaskModel(id: key, title: "消されるタスク", check: false, priority: 0));

      // 本物の deleteTask を呼ぶ
      viewModel.deleteTask(key);

      expect(viewModel.getTasks().length, 0);
    });

  });
}