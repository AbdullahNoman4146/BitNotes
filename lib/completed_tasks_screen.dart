import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'todo_controller.dart';

class CompletedTasksScreen extends StatelessWidget {
  final TodoController todoController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Completed Tasks")),
      body: Obx(() {
        return todoController.completedTodos.isEmpty
            ? Center(child: Text("No completed tasks yet!"))
            : ListView.builder(
          itemCount: todoController.completedTodos.length,
          itemBuilder: (context, index) {
            final todo = todoController.completedTodos[index];
            return ListTile(
              tileColor: Colors.green[100],
              title: Text(
                todo['task'],
                style: TextStyle(decoration: TextDecoration.lineThrough),
              ),
              subtitle: Text("Completed on: ${todo['date']}"),
            );
          },
        );
      }),
    );
  }
}