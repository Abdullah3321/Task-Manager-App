import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'login_screen.dart';

void main() {
  runApp(TaskManagerApp());
}

class TaskManagerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Manager',
      theme: ThemeData(
        primaryColor: Color(0xFF5EC576),
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Arial',
        textTheme: TextTheme(
          bodyMedium: TextStyle(color: Colors.black87),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          filled: true,
          fillColor: Colors.grey.shade100,
        ),
      ),
      home: LoginScreen(),
    );
  }
}
