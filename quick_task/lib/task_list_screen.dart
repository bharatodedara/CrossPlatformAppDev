// task_list_screen.dart

import 'package:flutter/material.dart';
import 'task_model.dart';
import 'task_service.dart';

class TaskListScreen extends StatefulWidget {
  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  List<Task> tasks = [];

  @override
  void initState() {
    super.initState();
    // Fetch tasks when the screen is initialized
    _fetchTasks();
  }

  Future<void> _fetchTasks() async {
    //final response = await TaskService.getTasks();
    final TaskService1 = TaskService();
    final response = await TaskService1.getTasks();
    if (response.success && response.results != null) {
      setState(() {
        tasks = response.results!.map((taskObject) {
          // Extract fields from ParseObject
          final objectId = taskObject.objectId;
          final title = taskObject.get<String>('title');
          final dueDate = taskObject.get<DateTime>('dueDate');
          final isCompleted = taskObject.get<bool>('isCompleted') ?? false;
          // Create Task object
          return Task(
            objectId: objectId ?? '',
            title: title ?? '',
            dueDate: dueDate ?? DateTime.now(),
            isCompleted: isCompleted,
          );
        }).toList();
      });
    } else {
      // Handle error
      print(response.error!.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        return ListTile(
          title: Text(task.title),
          subtitle: Text('Due Date: ${task.dueDate}'),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Checkbox(
                value: task.isCompleted,
                onChanged: (value) => _toggleTaskStatus(task, value),
              ),
              Text(task.isCompleted
                  ? 'Completed'
                  : 'Not Completed'), // Display "Completed" text based on task status
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () => _deleteTask(task),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _deleteTask(Task task) async {
    //final response = await TaskService.deleteTask(task.objectId!);
    final TaskService1 = TaskService();
    final response = await TaskService1.deleteTask(task.objectId!);
    if (response.success) {
      setState(() {
        tasks.remove(task);
      });
    } else {
      // Handle error
      print(response.error!.message);
    }
  }

  Future<void> _toggleTaskStatus(Task task, bool? value) async {
    if (value != null) {
      final updatedTask = task.copyWith(isCompleted: value);
      final response =
          await TaskService.updateTask(updatedTask.objectId!, value);
      if (response.success) {
        setState(() {
          tasks[tasks.indexOf(task)] = updatedTask;
        });
      } else {
        // Handle error
        print(response.error!.message);
      }
    }
  }
}
