// task_management_screen.dart

import 'package:flutter/material.dart';
import 'task_list_screen.dart'; // Import task list screen
import 'add_task_screen.dart';
import 'login_screen.dart';

class TaskManagementScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Management'),
        centerTitle: true, // Center the title and actions within the AppBar
        flexibleSpace: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spacer(),
                ElevatedButton(
                  onPressed: () {
                    // Navigate to login screen when Logout button is pressed
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            LoginScreen(), // Navigate to LoginScreen
                      ),
                    );
                  },
                  child: Text('Logout'),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Add task button
          ElevatedButton(
            onPressed: () {
              // Navigate to add task screen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddTaskScreen(),
                ),
              );
            },
            child: Text('Add Task'),
          ),
          SizedBox(
              height: 20.0), // Add spacing between the button and the label
          Text(
            'List of Tasks:', // Add label text
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          // Add more widgets here for displaying the list of tasks
          // Task list
          Expanded(
            child: TaskListScreen(),
          ),
        ],
      ),
    );
  }
}
