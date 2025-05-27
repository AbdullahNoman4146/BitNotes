import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'firestore_service.dart';

class TodoController extends GetxController {
  final FirestoreService _firestoreService = FirestoreService();
  var todos = <Map<String, dynamic>>[].obs;
  var completedTodos = <Map<String, dynamic>>[].obs;
  var viewAsGrid = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchTodos();
  }

  void fetchTodos() {
    _firestoreService.getTasks().listen((QuerySnapshot snapshot) {
      todos.value = snapshot.docs
          .where((doc) => doc['isCompleted'] == false) // Only fetch incomplete tasks
          .map((doc) {
        return {
          'id': doc.id,
          'task': doc['task'],
          'date': doc['date'],
          'isCompleted': doc['isCompleted'],
        };
      }).toList();

      completedTodos.value = snapshot.docs
          .where((doc) => doc['isCompleted'] == true) // Fetch completed tasks
          .map((doc) {
        return {
          'id': doc.id,
          'task': doc['task'],
          'date': doc['date'],
          'isCompleted': doc['isCompleted'],
        };
      }).toList();
    });
  }

  void addTodo(String task, String date) {
    _firestoreService.addTask(task, date);
  }

  void deleteTask(String id) {
    _firestoreService.deleteTask(id);
  }

  // Mark a task as completed and move it to the completed list
  void completeTodo(String id) {
    final taskIndex = todos.indexWhere((task) => task['id'] == id);
    if (taskIndex != -1) {
      final task = todos[taskIndex];
      task['isCompleted'] = true; // Mark as completed
      completedTodos.add(task); // Add to completed tasks list
      todos.removeAt(taskIndex); // Remove from active tasks list
      _firestoreService.completeTask(id); // Update Firestore
    }
  }

  void toggleView() {
    viewAsGrid.value = !viewAsGrid.value;
  }
}