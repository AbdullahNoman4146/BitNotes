import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Add a new note
  Future<void> addNote(String title, String content, String color, bool isPinned) async {
    await _firestore.collection('notes').add({
      'title': title,
      'content': content,
      'color': color,
      'isPinned': isPinned,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  // Get all notes
  Stream<QuerySnapshot> getNotes() {
    return _firestore.collection('notes').orderBy('timestamp', descending: true).snapshots();
  }

  // Delete a note
  Future<void> deleteNote(String id) async {
    await _firestore.collection('notes').doc(id).delete();
  }

  // Edit a note
  Future<void> editNote(String id, String title, String content, String color, bool isPinned) async {
    await _firestore.collection('notes').doc(id).update({
      'title': title,
      'content': content,
      'color': color,
      'isPinned': isPinned,
    });
  }

  // Add a new task
  Future<void> addTask(String task, String date) async {
    await _firestore.collection('tasks').add({
      'task': task,
      'date': date,
      'isCompleted': false,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  // Get all tasks
  Stream<QuerySnapshot> getTasks() {
    return _firestore.collection('tasks').orderBy('timestamp', descending: true).snapshots();
  }

  // Delete a task
  Future<void> deleteTask(String id) async {
    await _firestore.collection('tasks').doc(id).delete();
  }

  // Mark a task as completed
  Future<void> completeTask(String id) async {
    await _firestore.collection('tasks').doc(id).update({
      'isCompleted': true,
    });
  }
}