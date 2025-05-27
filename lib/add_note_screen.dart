import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'note_controller.dart';

class AddNoteScreen extends StatelessWidget {
  final NoteController noteController = Get.find();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  final List<String> colors = ["white", "red", "blue", "green", "yellow"];
  final RxString selectedColor = "white".obs;
  final RxBool isPinned = false.obs;

  final int? editIndex;
  final String? initialTitle;
  final String? initialContent;
  final String? initialColor;
  final bool? initialIsPinned;

  AddNoteScreen({
    this.editIndex,
    this.initialTitle,
    this.initialContent,
    this.initialColor,
    this.initialIsPinned,
  });

  @override
  Widget build(BuildContext context) {
    if (editIndex != null) {
      titleController.text = initialTitle!;
      contentController.text = initialContent!;
      selectedColor.value = initialColor!;
      isPinned.value = initialIsPinned!;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(editIndex == null ? "New Note" : "Edit Note"),
        actions: [
          Obx(() => IconButton(
            icon: Icon(isPinned.value ? Icons.push_pin : Icons.push_pin_outlined),
            onPressed: () {
              isPinned.toggle();
            },
          )),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                hintText: "Title",
                border: InputBorder.none,
                hintStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            TextField(
              controller: contentController,
              decoration: InputDecoration(
                hintText: "Start writing...",
                border: InputBorder.none,
              ),
              maxLines: null,
              keyboardType: TextInputType.multiline,
            ),
            SizedBox(height: 20),
            Text("Color Tag:", style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Obx(() => Row(
              children: colors.map((color) {
                return GestureDetector(
                  onTap: () {
                    selectedColor.value = color;
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: 10),
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: _getColorFromString(color),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: selectedColor.value == color
                            ? Colors.black
                            : Colors.transparent,
                        width: 2,
                      ),
                    ),
                  ),
                );
              }).toList(),
            )),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton(
                  onPressed: () {
                    // Implement functionality to add images or bullet tags
                  },
                  child: Icon(Icons.add),
                  mini: true,
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    if (titleController.text.isNotEmpty &&
                        contentController.text.isNotEmpty) {
                      if (editIndex == null) {
                        noteController.addNote(
                          titleController.text,
                          contentController.text,
                          selectedColor.value,
                          isPinned: isPinned.value,
                        );
                      } else {
                        noteController.editNote(
                          noteController.notes[editIndex!]['id'], // Pass the note ID as a String
                          titleController.text,
                          contentController.text,
                          selectedColor.value,
                          isPinned: isPinned.value,
                        );
                      }
                      Get.back();
                    } else {
                      Get.snackbar(
                        "Error",
                        "Please fill in the title and content",
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    }
                  },
                  child: Text(editIndex == null ? "Save" : "Update"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getColorFromString(String color) {
    switch (color) {
      case "red":
        return Colors.red;
      case "blue":
        return Colors.blue;
      case "green":
        return Colors.green;
      case "yellow":
        return Colors.yellow;
      default:
        return Colors.white;
    }
  }
}