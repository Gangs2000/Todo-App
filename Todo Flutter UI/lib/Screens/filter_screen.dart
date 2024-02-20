import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Models/task_data.dart';

class FilterScreen extends StatefulWidget{

  const FilterScreen({Key? key}): super(key: key);

  @override
  _FilterScreenState createState()=>_FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen>{

  String selectedOption='0';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Select Option'),
      content: DropdownButton<String>(
        value: selectedOption,
        onChanged: (newValue){
          setState(() {
            selectedOption=newValue!;
          });
        },
        items: const [
          DropdownMenuItem<String>(
              value: '0',
              child: Text('Created')
          ),
          DropdownMenuItem<String>(
              value: '1',
              child: Text('In progress')
          ),
          DropdownMenuItem<String>(
              value: '2',
              child: Text('Done')
          )
        ],
      ),
      actions: [
        TextButton(
          onPressed: (){
            if(selectedOption.isNotEmpty) {
              Provider.of<TaskData>(context, listen: false).getTasksByStatus(int.parse(selectedOption));
              Navigator.pop(context);
            }
          },
          style: ButtonStyle(
              backgroundColor: MaterialStateColor.resolveWith((states) => Colors.black),
              foregroundColor: MaterialStateColor.resolveWith((states) => Colors.yellow)
          ),
          child: const Text('Filter'),
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