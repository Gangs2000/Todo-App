import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo/Models/task_data.dart';
import 'package:todo/Screens/filter_screen.dart';
import 'package:todo/Screens/task_tile.dart';

import '../Models/task_item.dart';
import 'add_task_screen.dart';

class HomeScreen extends StatefulWidget{

  const HomeScreen({Key? key}) : super(key: key);
  
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>{

  int selectedIndex=0;

  void getTasks() async{
    Provider.of<TaskData>(context, listen: false).getTasks();
    setState(() {});
  }

  @override
  void initState(){
    super.initState();
    getTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: AppBar(
              title: Text(
                'Todo Tasks (${Provider.of<TaskData>(context).tasks.length})'
              ),
              centerTitle: true,
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              shape: Border.merge(Border.all(style: BorderStyle.solid), Border.all(style: BorderStyle.solid)),
            ),
            body: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SearchBar(
                    leading: const Icon(Icons.search, color: Colors.black),
                    padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20)
                    ),
                    hintText: 'Search Tasks...',
                    hintStyle: MaterialStateProperty.all(
                        const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold
                    )),
                    textStyle: MaterialStateProperty.all(
                      const TextStyle(color: Colors.black)
                    ),
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                    onChanged: (newValue){
                      Provider.of<TaskData>(context, listen: false).searchTasks(newValue, selectedIndex);
                    },
                  ),
                  const SizedBox(height: 15),
                  Expanded(
                      child: Consumer<TaskData>(
                        builder: (context, taskData, child){
                          return ListView.builder(
                            itemCount: taskData.tasks.length,
                            itemBuilder: (context, index){
                              TaskItem taskItem=taskData.tasks[index];
                              return TaskTile(taskItem: taskItem, taskData: taskData);
                            },
                          );
                        },
                      )
                  )
                ],
              )
            ),
            bottomNavigationBar: BottomNavigationBar(
              fixedColor: Colors.yellow,
              backgroundColor: Colors.black,
              unselectedItemColor: Colors.white,
              type: BottomNavigationBarType.fixed,
              iconSize: 22,
              selectedFontSize: 12,
              unselectedFontSize: 12,
              onTap: (index) async {
                setState(() {
                  selectedIndex=index;
                });
                if(selectedIndex==0){
                  //Method to fetch all Tasks
                  Provider.of<TaskData>(context, listen: false).getTasks();
                }
                else if(selectedIndex==1){
                  showDialog(
                    context: context,
                    builder: (context){
                      //Method to add new Task
                      return const AddTaskScreen();
                    },
                  );
                }
                else if(selectedIndex==2){
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime.now(),
                  );
                  if (picked != null) {
                    String selectedDate = DateFormat('yyyy-MM-dd').format(picked).split(" ")[0];
                    //Method to fetch list of items on the picked date
                    Provider.of<TaskData>(context, listen: false).getTasksByDate(selectedDate!);
                  }
                }
                else if(selectedIndex==3){
                  showDialog(
                      context: context,
                      builder: (context){
                        return const FilterScreen();
                      }
                  );
                }
              },
              currentIndex: selectedIndex,
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home',
                    tooltip: 'Home',
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.add),
                    label: 'Add Task',
                    tooltip: 'Add Task',
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.date_range),
                    label: 'Date Picker',
                    tooltip: 'Date Picker',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.filter_alt),
                  label: 'Filter',
                  tooltip: 'Filter',
                ),
              ],
            ),
        );
    }
}

