import 'package:flutter/cupertino.dart';
import 'package:todo/Models/task_item.dart';
import 'package:todo/Services/api_consumer.dart';

class TaskData extends ChangeNotifier{
  List<TaskItem> tasks=[];
  int filterQuery=0;  //For storing current filter status
  String dateQuery='';  //For storing current date status

  //Adding Task to Postgres
  void addTask(String taskName) async {
    TaskItem taskItem = await ApiConsumer.addTask(taskName);
    tasks.add(taskItem);
    notifyListeners();
  }

  //Get All Tasks
  void getTasks() async {
    List<TaskItem> taskItems=await ApiConsumer.getTasks();
    tasks.clear();
    tasks.addAll(taskItems);
    notifyListeners();
  }

  //Get Tasks By Status
  void getTasksByStatus(int status) async {
    List<TaskItem> taskItems=await ApiConsumer.getTasksByStatus(status);
    tasks.clear();
    tasks.addAll(taskItems);
    filterQuery=status;
    notifyListeners();
  }

  //Get Tasks by Date
  void getTasksByDate(String dateString) async {
    List<TaskItem> taskItems=await ApiConsumer.getTasksByDate(dateString);
    tasks.clear();
    tasks.addAll(taskItems);
    dateQuery=dateString;
    notifyListeners();
  }

  //Update Task Status to Postgres
  void updateTaskStatus(TaskItem taskItem) async {
    taskItem.toggleTask();
    await ApiConsumer.updateTaskStatus(taskItem.taskId);
    notifyListeners();
  }

  //Update Task Name to Postgres
  void updateTaskName(int taskId, String taskName) async {
    await ApiConsumer.updateTaskName(taskId, taskName);
    notifyListeners();
  }

  //Search Tasks
  void searchTasks(String pattern, int currentTab) async {
    List<TaskItem> taskItems=[];
    if(pattern.isEmpty) {
      switch(currentTab){
        case 0 || 1 : taskItems.addAll(await ApiConsumer.getTasks()); break;
        case 2 : taskItems.addAll(await ApiConsumer.getTasksByDate(dateQuery)); break;
        case 3 : taskItems.addAll(await ApiConsumer.getTasksByStatus(filterQuery)); break;
      }
    }
    else {
      //Iterating current tasks list
      for (TaskItem taskItem in tasks) {
        //Checking if current taskItem contains given pattern
        if (taskItem.taskName.toLowerCase().contains(pattern.toLowerCase())) {
          //If pattern is matched then add it to taskItems list
          taskItems.add(taskItem);
        }
      }
    }
    tasks.clear();
    tasks.addAll(taskItems);
    notifyListeners();
  }

  //Delete Task from Postgres
  void deleteTask(TaskItem taskItem) async {
    tasks.remove(taskItem);
    await ApiConsumer.deleteTask(taskItem.taskId);
    notifyListeners();
  }
}