import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'login_screen.dart';

class SignUpController extends GetxController {
  var usernameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();

  var isPasswordHidden = true.obs;
  var isConfirmPasswordHidden = true.obs;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  void signUp() async {
    String username = usernameController.text.trim();
    String email = emailController.text.trim();
    String password = passwordController.text;
    String confirmPassword = confirmPasswordController.text;

    if (username.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      Get.snackbar("Error", "Please fill all fields", snackPosition: SnackPosition.BOTTOM);
      return;
    }

    if (username.length < 3) {
      Get.snackbar("Error", "Username must be at least 3 characters long", snackPosition: SnackPosition.BOTTOM);
      return;
    }

    if (!email.endsWith("@gmail.com")) {
      Get.snackbar("Error", "Email must be a Gmail address", snackPosition: SnackPosition.BOTTOM);
      return;
    }

    if (password.length < 7 || !RegExp(r'^(?=.*[A-Za-z])(?=.*\d|.*[@$!%*?&])').hasMatch(password)) {
      Get.snackbar("Error", "Password must be at least 7 characters and contain letters, digits, or symbols", snackPosition: SnackPosition.BOTTOM);
      return;
    }

    if (password != confirmPassword) {
      Get.snackbar("Error", "Passwords do not match!", snackPosition: SnackPosition.BOTTOM);
      return;
    }

    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      Get.off(() => LoginScreen());
      Get.snackbar("Success", "Account created! Please log in.", snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      Get.snackbar("Error", e.toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }
}
