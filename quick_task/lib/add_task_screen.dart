// add_task_screen.dart

import 'package:flutter/material.dart';
import 'task_model.dart';
import 'task_service.dart';
import 'task_management_screen.dart';

class AddTaskScreen extends StatefulWidget {
  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  late TextEditingController _titleController;
  late DateTime _dueDate;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _dueDate = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Task'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            SizedBox(height: 20.0),
            Text('Due Date: ${_dueDate.toString()}'),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () => _selectDueDate(context),
              child: Text('Select Due Date'),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _addTask,
              child: Text('Add Task'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDueDate(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _dueDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null && pickedDate != _dueDate) {
      setState(() {
        _dueDate = pickedDate;
      });
    }
  }

  Future<void> _addTask() async {
    final title = _titleController.text.trim();
    if (title.isNotEmpty) {
      final task = Task(
          objectId: '', title: title, dueDate: _dueDate, isCompleted: false);
      final TaskService1 = TaskService();
      print('add_task_76');
      final response = await TaskService1.addTask(task);
      print('add_task_79');
      if (response.success) {
        Navigator.pop(context);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
                TaskManagementScreen(), // Navigate to LoginScreen
          ),
        );
        // Navigator.pop(
        //   context, updatedTasks); // Close the screen after adding task
      } else {
        // Handle error
        print(response.error!.message);
      }
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }
}
