import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_test/features/todo_list/cubit/todo_cubit.dart';
import 'package:flutter_application_test/features/todo_list/model/todo_item.dart';

class TodoListAddPage extends StatelessWidget {
  const TodoListAddPage({Key? key, required this.cubit}) : super(key: key);
  final TodoCubit cubit;

  @override
  Widget build(BuildContext context) {
    GlobalKey _formKey = GlobalKey<FormState>();
    final _titleController = TextEditingController();
    final _dateController = TextEditingController();

    void _onPress() {
      cubit.addItem(
        TodoItem(
          todoId: "todo${Random().nextDouble().toString()}",
          title: _titleController.text,
          timeDone: DateTime.now().add(
            Duration(
              days: int.parse(_dateController.text),
            ),
          ),
        ),
      );
      Navigator.pop(context);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Add item"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  hintText: "Enter Title",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return "Please provide title";
                  return null;
                },
              ),
              TextFormField(
                controller: _dateController,
                decoration: InputDecoration(
                  hintText: "Enter Days Target",
                ),
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return "Please provide title";
                  return null;
                },
              ),
              const SizedBox(
                height: 50,
              ),
              ElevatedButton(
                onPressed: _onPress,
                child: Text("Save"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
