import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'login_controller.dart';
import 'signup_screen.dart';

class LoginScreen extends StatelessWidget {
  final LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "bit",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    TextSpan(
                      text: "Notes",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Login",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),

              // Username Field
              TextField(
                controller: controller.usernameController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  hintText: "Email",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Password Field with Eye Icon
              Obx(() => TextField(
                controller: controller.passwordController,
                obscureText: controller.isPasswordHidden.value,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                  hintText: "Password",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      controller.isPasswordHidden.value
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () {
                      controller.isPasswordHidden.value =
                      !controller.isPasswordHidden.value;
                    },
                  ),
                ),
              )),
              const SizedBox(height: 8),

              // Remember Me Checkbox
              Row(
                children: [
                  Obx(() => Checkbox(
                    value: controller.rememberMe.value,
                    onChanged: (value) {
                      controller.rememberMe.value = value!;
                    },
                  )),
                  const Text("Remember me"),
                ],
              ),
              const SizedBox(height: 16),

              // Login Button
              ElevatedButton(
                onPressed: () {
                  controller.login();
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 14, horizontal: 100),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  backgroundColor: Colors.blue,
                ),
                child: Text(
                  "LOG IN",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // Forgot Password Button
              TextButton(
                onPressed: () {
                  // Implement Forgot Password functionality
                },
                child: const Text(
                  "Forget Password",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              const SizedBox(height: 16),

              // Sign Up Button
              GestureDetector(
                onTap: () {
                  Get.to(() => SignUpScreen());
                },
                child: const Text.rich(
                  TextSpan(
                    text: "Not a member? ",
                    style: TextStyle(color: Colors.grey),
                    children: [
                      TextSpan(
                        text: "Sign up now",
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}