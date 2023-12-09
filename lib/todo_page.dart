import 'package:flutter/material.dart';

class ToDoPage extends StatefulWidget {
  const ToDoPage({Key? key}) : super(key: key);

  @override
  _ToDoPageState createState() => _ToDoPageState();
}

class _ToDoPageState extends State<ToDoPage> {
  List<String> _tasks = [];
  TextEditingController _taskController = TextEditingController();
  int? _editIndex;

  void _addTask() {
    setState(() {
      String task = _taskController.text.trim();
      if (task.isNotEmpty) {
        if (_editIndex != null) {
          // Edit existing task
          _tasks[_editIndex!] = task;
          _editIndex = null;
        } else {
          // Add new task
          _tasks.add(task);
        }
        _taskController.clear();
      }
    });
  }

  void _removeTask(int index) {
    setState(() {
      _tasks.removeAt(index);
    });
  }

  void _startEdit(int index) {
    setState(() {
      _taskController.text = _tasks[index];
      _editIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Black background
      appBar: AppBar(
        title: const Text('To-Do List', style: TextStyle(color: Colors.white)), // White text
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white), // White icon
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.grey[900], // Dark Grey
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _taskController,
              style: TextStyle(color: Colors.white), // White text
              decoration: InputDecoration(
                labelText: 'Task',
                labelStyle: TextStyle(color: Colors.white), // White label text
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.grey[700], // Grey
              ),
            ),
          ),
          ElevatedButton(
            onPressed: _addTask,
            child: const Text('Add/Edit Task', style: TextStyle(color: Colors.white)), // White text
            style: ElevatedButton.styleFrom(
              primary: Colors.grey[700], // Grey
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _tasks.length,
              itemBuilder: (context, index) => Card(
                elevation: 3,
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                color: Colors.grey[900], // Dark Grey
                child: ListTile(
                  title: Text(_tasks[index], style: TextStyle(color: Colors.white)), // White text
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit, color: Colors.white), // White icon
                        onPressed: () => _startEdit(index),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.white), // White icon
                        onPressed: () => _removeTask(index),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
