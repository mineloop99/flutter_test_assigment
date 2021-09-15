import 'package:intl/intl.dart';

class TodoItem {
  final String todoId;
  String title;
  DateTime timeCreate = DateTime.now();
  DateTime timeDone;
  bool isDone;

  TodoItem({
    required this.todoId,
    required this.title,
    required this.timeDone,
    this.isDone = false,
  });

  String get timeDoneToString {
    return DateFormat.yMd().format(timeDone);
  }



  factory TodoItem.fromJson(Map<String, dynamic> json) {
    return TodoItem(
      todoId: json['todoId'] as String,
      title: json['title'] as String,
      timeDone: DateFormat.yMd().parse(json['timeDone'] as String) ,
      isDone: json['isDone'] as bool,
    );
  }

  Map<String, dynamic> toJson() => 
  {
    'todoId': todoId,
    'title': title,
    'timeCreate':timeCreate.toIso8601String(),
    'isDone': isDone,
    'timeDone':timeDoneToString,
  };
}
