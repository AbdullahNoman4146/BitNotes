import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'note_controller.dart';
import 'add_note_screen.dart';

class NotesScreen extends StatelessWidget {
  final NoteController noteController = Get.put(NoteController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notes"),
        actions: [
          IconButton(
            icon: Obx(() => Icon(
                noteController.viewAsGrid.value ? Icons.list : Icons.grid_view)),
            onPressed: () => noteController.toggleView(),
          ),
        ],
      ),
      body: Obx(() {
        if (noteController.notes.isEmpty) {
          return Center(child: Text("No notes yet!"));
        }

        return noteController.viewAsGrid.value
            ? GridView.builder(
          padding: EdgeInsets.all(10),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1.2,
          ),
          itemCount: noteController.notes.length,
          itemBuilder: (context, index) {
            final note = noteController.notes[index];
            return GestureDetector(
              onTap: () => _navigateToEditNoteScreen(index, note),
              child: Card(
                color: _getColorFromString(note['color']),
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        note['title'],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 5),
                      Expanded(
                        child: Text(
                          note['content'],
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      if (note['isPinned'])
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Icon(Icons.push_pin, size: 16),
                        ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () => noteController.deleteNote(note['id']),
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
          itemCount: noteController.notes.length,
          itemBuilder: (context, index) {
            final note = noteController.notes[index];
            return GestureDetector(
              onTap: () => _navigateToEditNoteScreen(index, note),
              child: Card(
                color: _getColorFromString(note['color']),
                child: ListTile(
                  title: Text(
                    note['title'],
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    note['content'],
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (note['isPinned'])
                        Icon(Icons.push_pin, size: 16),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () => noteController.deleteNote(note['id']),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => AddNoteScreen()),
        child: Icon(Icons.add),
      ),
    );
  }

  void _navigateToEditNoteScreen(int index, Map<String, dynamic> note) {
    Get.to(() => AddNoteScreen(
      editIndex: index,
      initialTitle: note['title'],
      initialContent: note['content'],
      initialColor: note['color'],
      initialIsPinned: note['isPinned'],
    ));
  }

  Color _getColorFromString(String color) {
    switch (color) {
      case "red":
        return Colors.red[100]!;
      case "blue":
        return Colors.blue[100]!;
      case "green":
        return Colors.green[100]!;
      case "yellow":
        return Colors.yellow[100]!;
      default:
        return Colors.white;
    }
  }
}