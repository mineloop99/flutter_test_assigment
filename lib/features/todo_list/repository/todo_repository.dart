import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:flutter_application_test/features/todo_list/model/todo_item.dart';

abstract class TodoRepository {
  Future<List<TodoItem>> fetchRepository();
}

class DummyRepository implements TodoRepository {
  final http.Client client = http.Client();

  @override
  Future<List<TodoItem>> fetchRepository() async {
    Random rand = Random();
    final _listRepo = List.generate(
      3,
      (index) => TodoItem(
        title: "Random Action ${rand.nextInt(99) + index}",
        timeDone: DateTime.now().add(
          Duration(
            days: rand.nextInt(66),
          ),
        ),
        todoId: '_listItem${rand.nextInt(99) + index}',
        isDone: rand.nextBool(),
      ),
    );

    return _listRepo;
  }
}
