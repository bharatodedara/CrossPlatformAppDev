// task_service.dart

import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'task_model.dart';

class TaskService {
  List<Task> tasks = [];
  Future<ParseResponse> addTask(Task task) async {
    final parseObject = ParseObject('Tasks')
      ..set('title', task.title)
      ..set('dueDate', task.dueDate)
      ..set('isCompleted', task.isCompleted);
    return await parseObject.save();
  }

  Future<ParseResponse> getTasks() async {
    final queryBuilder = QueryBuilder<ParseObject>(ParseObject('Tasks'))
      ..orderByDescending('createdAt');

    return await queryBuilder.query();
  }

  Future<ParseResponse> deleteTask(String objectId) async {
    final parseObject = ParseObject('Tasks')..objectId = objectId;
    return await parseObject.delete();
  }

  static Future<ParseResponse> updateTask(String objectId, bool? value) async {
    // Implementation to update a task on the backend
    // For example, if you're using Parse Server, you would typically use the save() method to update an object
    //try {

    final parseObject = ParseObject('Tasks')..objectId = objectId;
    parseObject..set('isCompleted', value);

    return await parseObject.update();
  }
}
