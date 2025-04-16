import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> tasks = [
    'Improve profile on Linkdein   - Due: April 20th, 2025'
  ];
  List<bool> completed = [false];
  TextEditingController taskController = TextEditingController();
  DateTime? selectedDate;

  void addTask(String task) {
    setState(() {
      tasks.add(task);
      completed.add(false);
      taskController.clear();
      selectedDate = null;
    });
  }

  void deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
      completed.removeAt(index);
    });
  }

  void toggleComplete(int index) {
    setState(() {
      completed[index] = !completed[index];
    });
  }

  void pickDate() async {
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (date != null) {
      setState(() {
        selectedDate = date;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF3F4F6),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(color: Colors.black),
        title: Text('Dashboard', style: TextStyle(color: Colors.black)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('TaskMaster',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800])),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: taskController,
                    decoration: InputDecoration(
                      hintText: 'Add a new task',
                      filled: true,
                      fillColor: Colors.grey[100],
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: pickDate,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[100],
                    foregroundColor: Colors.black,
                  ),
                  child: Text(selectedDate == null
                      ? 'Pick a date'
                      : '${selectedDate!.month}/${selectedDate!.day}/${selectedDate!.year}'),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    if (taskController.text.trim().isNotEmpty) {
                      String taskText = taskController.text.trim();
                      if (selectedDate != null) {
                        taskText +=
                        '  -  Due: ${selectedDate!.month}/${selectedDate!.day}/${selectedDate!.year}';
                      }
                      addTask(taskText);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal[200],
                    foregroundColor: Colors.white,
                  ),
                  child: Text('Add Task'),
                ),
              ],
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) => ListTile(
                  leading: Checkbox(
                    value: completed[index],
                    onChanged: (_) => toggleComplete(index),
                  ),
                  title: Text(
                    tasks[index],
                    style: TextStyle(
                      decoration: completed[index]
                          ? TextDecoration.lineThrough
                          : null,
                      color: completed[index] ? Colors.grey : Colors.black,
                    ),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () => deleteTask(index),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
