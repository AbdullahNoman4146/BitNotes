import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'todo_controller.dart'; // Import the TodoController

class AddTodoScreen extends StatelessWidget {
  final TodoController todoController = Get.find<TodoController>(); // Access the controller
  final TextEditingController taskController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final DateTime? initialDate;

  AddTodoScreen({this.initialDate});

  @override
  Widget build(BuildContext context) {
    if (initialDate != null) {
      dateController.text =
      "${initialDate!.day}-${initialDate!.month}-${initialDate!.year}";
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("New To-Do"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: taskController,
              decoration: InputDecoration(labelText: "Task Name"),
            ),
            SizedBox(height: 20),
            TextField(
              controller: dateController,
              decoration: InputDecoration(
                labelText: "Due Date",
                suffixIcon: IconButton(
                  icon: Icon(Icons.calendar_today),
                  onPressed: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: initialDate ?? DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2100),
                    );
                    if (pickedDate != null) {
                      dateController.text =
                      "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}";
                    }
                  },
                ),
              ),
              readOnly: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (taskController.text.isNotEmpty && dateController.text.isNotEmpty) {
                  todoController.addTodo(taskController.text, dateController.text);
                  Get.back();
                } else {
                  Get.snackbar(
                    "Error",
                    "Please fill in the task name and due date",
                    snackPosition: SnackPosition.BOTTOM,
                  );
                }
              },
              child: Text("Save"),
            ),
          ],
        ),
      ),
    );
  }
}