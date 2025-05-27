import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'todo_controller.dart';
import 'completed_tasks_screen.dart';

class TodoScreen extends StatelessWidget {
  final TodoController todoController = Get.put(TodoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("To-Do"),
        actions: [
          IconButton(
            icon: Obx(() =>
                Icon(
                    todoController.viewAsGrid.value ? Icons.list : Icons
                        .grid_view)),
            onPressed: () => todoController.toggleView(),
          ),
          IconButton(
            icon: Icon(Icons.check_circle),
            onPressed: () => Get.to(() => CompletedTasksScreen()),
          ),
        ],
      ),
      body: Obx(() {
        if (todoController.todos.isEmpty) {
          return Center(child: Text("No tasks yet!"));
        }

        return todoController.viewAsGrid.value
            ? GridView.builder(
          padding: EdgeInsets.all(10),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1.5,
          ),
          itemCount: todoController.todos.length,
          itemBuilder: (context, index) {
            final todo = todoController.todos[index];
            return GestureDetector(
              onTap: () => _showEditTodoDialog(context, index, todo),
              child: Card(
                color: Colors.grey[200],
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        todo['task'],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          decoration: todo['isCompleted']
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        "Due: ${todo['date']}",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.check, color: Colors.green),
                              onPressed: () => todoController.completeTodo(todo['id']),
                            ),
                            IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () => todoController.deleteTask(todo['id']),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        )
            : ListView.builder(
          itemCount: todoController.todos.length,
          itemBuilder: (context, index) {
            final todo = todoController.todos[index];
            return GestureDetector(
              onTap: () => _showEditTodoDialog(context, index, todo),
              child: ListTile(
                tileColor: Colors.grey[200],
                title: Text(
                  todo['task'],
                  style: TextStyle(
                    decoration: todo['isCompleted']
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text("Due Date: ${todo['date']}"),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.check, color: Colors.green),
                      onPressed: () => todoController.completeTodo(todo['id']),
                    ),
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () => todoController.deleteTask(todo['id']),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddTodoDialog(context),
        child: Icon(Icons.add),
      ),
    );
  }

  void _showAddTodoDialog(BuildContext context) {
    final taskController = TextEditingController();
    final dateController = TextEditingController();

    showDialog(
      context: context,
      builder: (_) =>
          AlertDialog(
            title: Text("New Task"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: taskController,
                  decoration: InputDecoration(labelText: "Task Name"),
                ),
                TextField(
                  controller: dateController,
                  decoration: InputDecoration(
                    labelText: "Due Date",
                    suffixIcon: IconButton(
                      icon: Icon(Icons.calendar_today),
                      onPressed: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
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
              ],
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  if (taskController.text.isNotEmpty &&
                      dateController.text.isNotEmpty) {
                    todoController.addTodo(taskController.text, dateController.text);
                    Get.back();
                  } else {
                    Get.snackbar(
                        "Error", "Please select a date using the picker",
                        snackPosition: SnackPosition.BOTTOM);
                  }
                },
                child: Text("Add"),
              ),
            ],
          ),
    );
  }

  void _showEditTodoDialog(BuildContext context, int index, Map<String, dynamic> todo) {
    final taskController = TextEditingController(text: todo['task']);
    final dateController = TextEditingController(text: todo['date']);

    showDialog(
      context: context,
      builder: (_) =>
          AlertDialog(
            title: Text("Edit Task"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: taskController,
                  decoration: InputDecoration(labelText: "Task Name"),
                ),
                TextField(
                  controller: dateController,
                  decoration: InputDecoration(
                    labelText: "Due Date",
                    suffixIcon: IconButton(
                      icon: Icon(Icons.calendar_today),
                      onPressed: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
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
              ],
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  if (taskController.text.isNotEmpty &&
                      dateController.text.isNotEmpty) {
                    todoController.todos[index]['task'] = taskController.text;
                    todoController.todos[index]['date'] = dateController.text;
                    todoController.todos.refresh();
                    Get.back();
                  } else {
                    Get.snackbar("Error", "Please fill all fields",
                        snackPosition: SnackPosition.BOTTOM);
                  }
                },
                child: Text("Save"),
              ),
            ],
          ),
    );
  }
}