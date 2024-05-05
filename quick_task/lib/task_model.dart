// task_list.dart

import 'package:flutter/material.dart';
//import 'task_model.dart';
// task_model.dart

class Task {
  String objectId; // Add objectId field for CRUD operations
  String title;
  DateTime dueDate;
  bool isCompleted;

  Task(
      {required this.objectId,
      required this.title,
      required this.dueDate,
      this.isCompleted = false});
  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      objectId: json['objectId'],
      title: json['title'],
      dueDate: DateTime.parse(json['dueDate']),
      isCompleted: json['isCompleted'] ?? false,
    );
  }

  Task copyWith({
    String? objectId,
    String? title,
    DateTime? dueDate,
    bool? isCompleted,
  }) {
    return Task(
      objectId: objectId ?? this.objectId,
      title: title ?? this.title,
      dueDate: dueDate ?? this.dueDate,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}

class TaskList extends StatefulWidget {
  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  List<Task> tasks = [];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        return ListTile(
          title: Text(task.title),
          subtitle: Text('Due Date: ${task.dueDate}'),
          trailing: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              setState(() {
                tasks.removeAt(index);
              });
            },
          ),
        );
      },
    );
  }
}
