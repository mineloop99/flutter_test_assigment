import 'package:flutter/material.dart';
import 'package:flutter_application_test/features/todo_list/cubit/todo_cubit.dart';
import 'package:flutter_application_test/features/todo_list/model/todo_item.dart';

class TodoCard extends StatelessWidget {
  const TodoCard({Key? key, required this.todoItem, required this.cubit})
      : super(key: key);
  final TodoItem todoItem;
  final TodoCubit cubit;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      child: ListTile(
        leading: Checkbox( 
          value: todoItem.isDone,
          onChanged: (bool? value) { 
            cubit.onCheckedItem(todoItem);
           },
          ),
        title: Text(
          todoItem.title,
        ),
        subtitle: Text(
          todoItem.timeDoneToString,
        ),
        trailing: IconButton(
          onPressed: () {
            cubit.removeItem(todoItem.todoId);
          },
          icon: Icon(Icons.delete, color: Colors.red,),
        ),
      ),
    );
  }
}
