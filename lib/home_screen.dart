import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'notes_screen.dart';
import 'todo_screen.dart';
import 'bottom_nav_bar.dart';
import 'search_screen.dart'; // Import the SearchScreen

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int selectedIndex = 0;

  List<Map<String, dynamic>> notes = [
    // Your actual notes data here
  ];

  List<Map<String, dynamic>> tasks = [
    // Your actual tasks data here
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {
        selectedIndex = (_tabController.index == 0 || _tabController.index == 1) ? 0 : selectedIndex;
      });
    });
  }

  void _onNavBarTapped(int index) {
    if (index == 0) {
      _tabController.animateTo(0);
    }
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("bitNotes"),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: "Notes"),
            Tab(text: "To-Do"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          NotesScreen(),
          TodoScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: selectedIndex,
        onItemTapped: _onNavBarTapped,
        notes: notes,
        tasks: tasks,
      ),
    );
  }
}