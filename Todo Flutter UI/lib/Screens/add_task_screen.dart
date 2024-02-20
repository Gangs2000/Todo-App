import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/Models/task_data.dart';


class AddTaskScreen extends StatefulWidget{

  const AddTaskScreen({Key? key}): super(key: key);

  @override
  _AddTaskScreenState createState()=>_AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen>{

  String taskName="";

  @override
  Widget build(BuildContext context) {
    return  AlertDialog(
      title: const Text('Add Task'),
      content: TextFormField(
        autofocus: true,
        onChanged: (value){
          taskName=value;
        },
      ),
      actions: [
        TextButton(
          onPressed: (){
            if(taskName.isNotEmpty) {
              Provider.of<TaskData>(context, listen: false).addTask(taskName);
              Navigator.pop(context);
            }
          },
          style: ButtonStyle(
              backgroundColor: MaterialStateColor.resolveWith((states) => Colors.black),
              foregroundColor: MaterialStateColor.resolveWith((states) => Colors.yellow)
          ),
          child: const Text('Add'),
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
}