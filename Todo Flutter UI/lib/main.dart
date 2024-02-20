import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/Models/task_data.dart';
import 'package:todo/Screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TaskData>(
      create: (context) => TaskData(),
      child:  MaterialApp(
        title: 'Todo',
        debugShowCheckedModeBanner: false,
        home: const HomeScreen(),
        darkTheme: ThemeData.dark(),
      ),
    );
  }
}
