import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsController extends GetxController {
  var isDarkMode = false.obs;

  void toggleDarkMode() {
    isDarkMode.value = !isDarkMode.value;
    // Apply dark mode to the entire app
    if (isDarkMode.value) {
      Get.changeThemeMode(ThemeMode.dark); // Switch to dark theme
    } else {
      Get.changeThemeMode(ThemeMode.light); // Switch to light theme
    }
  }
}