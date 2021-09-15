import 'package:flutter_application_test/features/todo_list/model/todo_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  TodoCubit({required this.listTodoItem}) : super(TodoInitial());
  List<TodoItem> listTodoItem;

  void updateState() {
    emit(TodoStateChange());
  }

  void removeItem(String id) {
    listTodoItem.remove(
        listTodoItem.firstWhere((element) => element.todoId.contains(id)));
    updateState();
  }

  void addItem(TodoItem todoItem) {
    listTodoItem.add(todoItem);
    updateState();
  }

  void onCheckedItem(TodoItem todoItem) {
    todoItem.isDone = !todoItem.isDone;
    updateState();
  }
}
