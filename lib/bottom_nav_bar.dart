import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'search_screen.dart';
import 'calendar_screen.dart';
import 'menu_screen.dart';

class BottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;
  final List<Map<String, dynamic>> notes;
  final List<Map<String, dynamic>> tasks;

  BottomNavBar({required this.selectedIndex, required this.onItemTapped, required this.notes, required this.tasks});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: (index) {
        if (index == 1) {
          Get.offAll(() => CalendarScreen(notes: notes, tasks: tasks)); // Open Calendar Page
        } else if (index == 2) {
          Get.offAll(() => SearchScreen(notes: notes, tasks: tasks)); // Open Search Page
        } else if (index == 3) {
          Get.offAll(() => MenuScreen()); // Open Menu Page
        } else {
          onItemTapped(index);
        }
      },
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.note), label: 'Notes'),
        BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'Calendar'),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
        BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'Menu'),
      ],
    );
  }
}