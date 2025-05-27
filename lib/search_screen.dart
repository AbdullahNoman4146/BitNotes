import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'bottom_nav_bar.dart';

class SearchScreen extends StatefulWidget {
  final List<Map<String, dynamic>> notes;
  final List<Map<String, dynamic>> tasks;

  SearchScreen({required this.notes, required this.tasks});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _filteredResults = [];

  void _search(String query) {
    setState(() {
      _filteredResults = [...widget.notes, ...widget.tasks].where((item) {
        return item['title'].toLowerCase().contains(query.toLowerCase()) ||
            item['content'].toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search Notes & Tasks"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              onChanged: _search,
              decoration: InputDecoration(
                hintText: "Search...",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          Expanded(
            child: _filteredResults.isEmpty
                ? Center(child: Text("No results found"))
                : ListView.builder(
              itemCount: _filteredResults.length,
              itemBuilder: (context, index) {
                var item = _filteredResults[index];
                return ListTile(
                  leading: Icon(Icons.note, color: item['color']),
                  title: Text(
                    item['title'],
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(item['content']),
                  trailing: Text(item['date']),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: 2,
        onItemTapped: (index) {
          if (index == 0) {
            Get.offAllNamed('/home');
          } else if (index == 1) {
            Get.offAllNamed('/calendar');
          } else if (index == 3) {
            Get.offAllNamed('/menu');
          }
        },
        notes: widget.notes,
        tasks: widget.tasks,
      ),
    );
  }
}