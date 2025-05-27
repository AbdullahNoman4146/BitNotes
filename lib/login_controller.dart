import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  var usernameController = TextEditingController();
  var passwordController = TextEditingController();
  var isPasswordHidden = true.obs;
  var rememberMe = false.obs;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  void login() async {
    String email = usernameController.text.trim();
    String password = passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      Get.snackbar("Error", "Please enter email and password", snackPosition: SnackPosition.BOTTOM);
      return;
    }

    try {
      var p = await _auth.signInWithEmailAndPassword(email: email, password: password);
      Get.snackbar("Success", "Login Successful!", snackPosition: SnackPosition.BOTTOM);
      Get.offAllNamed('/home'); // Navigate to HomeScreen
    } catch (e) {
      Get.snackbar("Error", "Invalid email or password", snackPosition: SnackPosition.BOTTOM);
    }
  }
}
