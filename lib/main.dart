import 'package:bitnotes/add_todo_screen.dart';
import 'package:bitnotes/calendar_screen.dart';
import 'package:bitnotes/splash_screen.dart';
import 'package:bitnotes/login_screen.dart';
import 'package:bitnotes/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'settings_controller.dart';
import 'todo_controller.dart'; // Import the TodoController

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initialize the SettingsController and TodoController
  Get.put(SettingsController());
  Get.put(TodoController()); // Initialize TodoController here

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final SettingsController settingsController = Get.find();

    return Obx(() => GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/splash',
      theme: settingsController.isDarkMode.value ? ThemeData.dark() : ThemeData.light(),
      getPages: [
        GetPage(name: '/splash', page: () => SplashScreen()),
        GetPage(name: '/login', page: () => LoginScreen()),
        GetPage(name: '/home', page: () => HomeScreen()),
        GetPage(name: '/calendar', page: () => CalendarScreen(notes: [], tasks: [])),
        GetPage(name: '/addTodo', page: () => AddTodoScreen()), // Add this route
      ],
    ));
  }
}