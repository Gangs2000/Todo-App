import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:todo/Services/parameters.dart';

import '../Models/task_item.dart';

class ApiConsumer{

  //API Call to Add Task
  static Future<TaskItem> addTask(String taskName) async{
    Map data={
      "taskName":taskName
    };
    var body=json.encode(data);
    var addTaskUrl = Uri.parse('$baseUrl/addTask');
    http.Response response = await http.post(
      addTaskUrl,
      headers: headers,
      body: body
    );
    print(response.body);
    Map responseMap=jsonDecode(response.body);
    TaskItem taskItem=TaskItem.fromMap(responseMap);
    return taskItem;
  }

  //API Call to Get Tasks
  static Future<List<TaskItem>> getTasks() async{
    var getTasksUrl = Uri.parse('$baseUrl/getTasks');
    http.Response response = await http.get(
      getTasksUrl,
      headers: headers
    );
    List responseList = jsonDecode(response.body);
    List<TaskItem> tasks=[];
    for(Map taskMap in responseList){
      TaskItem taskItem=TaskItem.fromMap(taskMap);
      tasks.add(taskItem);
    }
    return tasks;
  }

  //API Call to Get Tasks by status
  static Future<List<TaskItem>> getTasksByStatus(int status) async {
    var getTasksByStatusUrl = Uri.parse('$baseUrl/getTasks/status/$status');
    http.Response response = await http.get(
      getTasksByStatusUrl,
      headers: headers
    );
    List responseList = jsonDecode(response.body);
    List<TaskItem> tasks=[];
    for(Map taskMap in responseList){
      TaskItem taskItem=TaskItem.fromMap(taskMap);
      tasks.add(taskItem);
    }
    return tasks;
  }

  //API Call to Get Tasks by Specific Date
  static Future<List<TaskItem>> getTasksByDate(String dateString) async {
    var getTasksByDateUrl = Uri.parse('$baseUrl/getTasks/localDate/$dateString');
    http.Response response = await http.get(
      getTasksByDateUrl,
      headers: headers
    );
    List responseList =  jsonDecode(response.body);
    List<TaskItem> tasks=[];
    for(Map taskMap in responseList){
      TaskItem taskItem=TaskItem.fromMap(taskMap);
      tasks.add(taskItem);
    }
    return tasks;
  }

  //API Call to Update Task Status
  static Future<http.Response> updateTaskStatus(int taskId) async {
    var updateTaskUrl = Uri.parse('$baseUrl/updateTaskStatus/taskId/$taskId');
    http.Response response = await http.put(
      updateTaskUrl,
      headers: headers
    );
    print(response.body);
    return response;
  }

  //API Call to Update Task Name
  static Future<http.Response> updateTaskName(int taskId, String taskName) async {
    Map data={
      "id":taskId,
      "taskName":taskName
    };
    var body=json.encode(data);
    var updateTaskUrl = Uri.parse('$baseUrl/updateTaskName');
    http.Response response = await http.put(
      updateTaskUrl,
      body: body,
      headers: headers
    );
    print(response.body);
    return response;
  }

  //API Call to Delete TaskItem
  static Future<http.Response> deleteTask(int taskId) async {
    var deleteTaskUrl =  Uri.parse('$baseUrl/deleteTask/taskId/$taskId');
    http.Response response = await http.delete(
      deleteTaskUrl,
      headers: headers
    );
    print(response.body);
    return response;
  }
}