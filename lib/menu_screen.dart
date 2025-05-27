import 'package:bitnotes/bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'settings_controller.dart';

class MenuScreen extends StatelessWidget {
  final SettingsController settingsController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Menu"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),

            // Dark Mode Toggle Button
            Obx(() => SwitchListTile(
              title: Text("Dark Mode"),
              value: settingsController.isDarkMode.value,
              onChanged: (value) {
                settingsController.toggleDarkMode();
              },
            )),

            SizedBox(height: 20),

            // Logout Button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Get.offAllNamed('/login'); // Navigate to the login screen
                },
                child: Text("Logout"),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: 3, // Menu is the fourth item in the navbar
        onItemTapped: (index) {
          if (index == 0) {
            Get.offAllNamed('/home'); // Navigate to HomeScreen
          } else if (index == 1) {
            Get.offAllNamed('/calendar'); // Navigate to CalendarScreen
          } else if (index == 2) {
            Get.offAllNamed('/search'); // Navigate to SearchScreen
          }
        },
        notes: [], // Pass empty lists if not needed
        tasks: [],
      ),
    );
  }
}