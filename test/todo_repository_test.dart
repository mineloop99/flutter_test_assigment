import 'dart:convert';

import 'package:flutter_application_test/features/todo_list/model/todo_item.dart';
import 'package:flutter_application_test/features/todo_list/repository/todo_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
main() {
  group('Test Fetch TodoList', () {
      test('return a List<TodoItem> if Succeed', () async {
        final itemFetch = DummyRepository();
        final listItem = await itemFetch.fetchRepository();
        expect(listItem, isA<List<TodoItem>>());
      });    
      
      test('return List<TodoItem> first matched if Succeed', () async {
        final todoItem = TodoItem (
                        todoId: 'id123',
                        title: 'take money',
                        timeDone: DateTime.now().add(
                          Duration(days: 10),
                        ),
                        isDone: true,
                      );
        
        final itemFetch = DummyRepository();
        final listItem = await itemFetch.fetchRepository();
        // List item now is Randomly set
        expect(
            listItem.first.isDone, todoItem.isDone,
            );
      });

    });

    group("Test Json Data", () {

      test('return Object From form Json if Succeed', () {
        //Test fetch item with Json Data
        final mapJsonTodoItem = TodoItem(
                        todoId: '123456',
                        title: 'hello money',
                        timeDone: DateTime.now().add(
                          Duration(days: 10),
                        ),
                        isDone: true,
        ).toJson();
        final res = http.Response(jsonEncode(mapJsonTodoItem), 200);
        final todoItem = TodoItem.fromJson(jsonDecode(res.body));

        expect(
            todoItem, isA<TodoItem>());
      });

      test('return Matched Object From form Json if Succeed', () async {
        final itemFetch = DummyRepository();
        final listItem = await itemFetch.fetchRepository();

        //Dummy fetch item with Json Data
        final mapJsonTodoItem = TodoItem(
                        todoId: 'id123',
                        title: 'take money',
                        timeDone: DateTime.now().add(
                          Duration(days: 10),
                        ),
                        isDone: true,
        ).toJson();
        final res = http.Response(jsonEncode(mapJsonTodoItem), 200);
        final matchItem = TodoItem.fromJson(jsonDecode(res.body));

        // Because using randomly ID it's always failed check repository and Test output for more infor
        expect(
            listItem.first.title, matchItem.title);
      });

    });
}
