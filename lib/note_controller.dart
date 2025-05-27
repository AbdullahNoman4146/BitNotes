import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'firestore_service.dart';

class NoteController extends GetxController {
  final FirestoreService _firestoreService = FirestoreService();
  var notes = <Map<String, dynamic>>[].obs;
  var viewAsGrid = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchNotes();
  }

  void fetchNotes() {
    _firestoreService.getNotes().listen((QuerySnapshot snapshot) {
      notes.value = snapshot.docs.map((doc) {
        return {
          'id': doc.id,
          'title': doc['title'],
          'content': doc['content'],
          'color': doc['color'],
          'isPinned': doc['isPinned'],
        };
      }).toList();
    });
  }

  void addNote(String title, String content, String color, {bool isPinned = false}) {
    _firestoreService.addNote(title, content, color, isPinned);
  }

  void editNote(String id, String title, String content, String color, {bool isPinned = false}) {
    _firestoreService.editNote(id, title, content, color, isPinned);
  }

  void deleteNote(String id) {
    _firestoreService.deleteNote(id);
  }

  void toggleView() {
    viewAsGrid.value = !viewAsGrid.value;
  }
}