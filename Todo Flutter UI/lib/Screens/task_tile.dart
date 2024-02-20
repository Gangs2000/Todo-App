import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../Models/task_data.dart';
import '../Models/task_item.dart';

class TaskTile extends StatelessWidget {
  final TaskItem taskItem;
  final TaskData taskData;
  const TaskTile({Key? key, required this.taskItem, required this.taskData}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
          subtitle: Text(DateFormat('dd-MMM-yyyy hh:mm a').format(taskItem.createdDateTime)),
        leading: Text(
          (taskItem.taskStatus==0)?('Created'):((taskItem.taskStatus==1)?('In Progress'):('Done')),
          style: TextStyle(
            color: (taskItem.taskStatus==0)?(Colors.yellow):((taskItem.taskStatus==1)?(Colors.red):(Colors.green)),
            fontWeight: FontWeight.bold,
            fontSize: 11
          ),
          textAlign: TextAlign.center,
        ),
          title: Text(
              taskItem.taskName,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                decoration: (taskItem.taskStatus==2)?TextDecoration.lineThrough:TextDecoration.none,
                color: (taskItem.taskStatus==2)?Colors.green:Colors.white,
              )
          ),
          horizontalTitleGap: (taskItem.taskStatus==0)?(70):((taskItem.taskStatus==1)?(50):(82)),
          trailing: Wrap(
            spacing: 5,
            children: [
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: (){
                  showDialog(
                      context: context,
                      builder: (BuildContext context){
                        return AlertDialog(
                          title: const Text("Edit Task"),
                          content: TextFormField(
                            initialValue: taskItem.taskName,
                            autofocus: true,
                            onChanged: (value){
                              taskItem.taskName=value;
                            },
                          ),
                          actions: [
                            TextButton(
                              onPressed: (){
                                if(taskItem.taskName.isNotEmpty) {
                                  taskData.updateTaskName(taskItem.taskId, taskItem.taskName);
                                  Navigator.pop(context);
                                }
                              },
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateColor.resolveWith((states) => Colors.black),
                                  foregroundColor: MaterialStateColor.resolveWith((states) => Colors.yellow)
                              ),
                              child: const Text('Save'),
                            ),
                            TextButton(
                                onPressed: (){
                                  Navigator.pop(context);
                                },
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateColor.resolveWith((states) => Colors.black),
                                    foregroundColor: MaterialStateColor.resolveWith((states) => Colors.yellow)
                                ),
                                child: const Text('Cancel')
                            )
                          ],
                        );
                      }
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: (){
                  showDialog(
                      context: context,
                      builder: (BuildContext context){
                        return AlertDialog(
                          title: const Text("Are you sure to delete?"),
                          content: TextFormField(
                            initialValue: taskItem.taskName,
                            readOnly: true,
                          ),
                          actions: [
                            TextButton(
                              onPressed: (){
                                taskData.deleteTask(taskItem);
                                Navigator.pop(context);
                              },
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateColor.resolveWith((states) => Colors.black),
                                  foregroundColor: MaterialStateColor.resolveWith((states) => Colors.yellow)
                              ),
                              child: const Text('Yes'),
                            ),
                            TextButton(
                                onPressed: (){
                                  Navigator.pop(context);
                                },
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateColor.resolveWith((states) => Colors.black),
                                    foregroundColor: MaterialStateColor.resolveWith((states) => Colors.yellow)
                                ),
                                child: const Text('No')
                            )
                          ],
                        );
                      }
                  );
                },
              ),
            ],
          ),
          onTap: (){
            taskData.updateTaskStatus(taskItem);
          },
      ),
    );
  }
}