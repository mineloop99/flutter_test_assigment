import 'package:flutter/material.dart';
import 'package:flutter_application_test/base/base_state_management/base_cubit.dart';
import 'package:flutter_application_test/features/todo_list/component/todo_card.dart';
import 'package:flutter_application_test/features/todo_list/cubit/todo_cubit.dart';
import 'package:flutter_application_test/features/todo_list/repository/todo_repository.dart';
import 'package:flutter_application_test/features/todo_list/todo_list_add_page.dart';
import 'package:http/http.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({Key? key}) : super(key: key);

  @override
  _TodoListPageState createState() => _TodoListPageState();
}

class _TodoListPageState
    extends BaseStatefulCubit<TodoListPage, TodoCubit, TodoState> {
  @override
  void initCubit() {
    cubit = TodoCubit(
      listTodoItem: [],
    );
  }

  @override
  void didChangeDependencies() async {
    cubit.listTodoItem =
        await DummyRepository().fetchRepository().then((value) {
      cubit.updateState();
      return value;
    });
    super.didChangeDependencies();
  }

  @override
  Widget builder(BuildContext context, TodoState state) {
    if (cubit.listTodoItem.isEmpty) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo Item"),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemBuilder: (_, index) {
          return TodoCard(
            todoItem: cubit.listTodoItem[index],
            cubit: cubit,
          );
        },
        itemCount: cubit.listTodoItem.length,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => TodoListAddPage(
                cubit: cubit,
              ),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
