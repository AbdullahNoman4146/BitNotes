import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(Duration(seconds: 4), () {
        Get.offAllNamed('/login'); // Navigate to Login Screen
      });
    });

    return Scaffold(
      backgroundColor: Color(0xFFFAEBD7),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedTextKit(
                  animatedTexts: [
                    TyperAnimatedText(
                      'bit',
                      textStyle: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade700,
                      ),
                      speed: Duration(milliseconds: 500),
                    ),
                  ],
                  totalRepeatCount: 1,
                ),
                SizedBox(width: 5),
                AnimatedTextKit(
                  animatedTexts: [
                    TyperAnimatedText(
                      'Notes',
                      textStyle: GoogleFonts.pacifico(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      speed: Duration(milliseconds: 500),
                    ),
                  ],
                  totalRepeatCount: 1,
                ),
              ],
            ),
            SizedBox(height: 20),
            AnimatedOpacity(
              opacity: 1.0,
              duration: Duration(seconds: 2),
              child: Text(
                "an attempt to keep life neat",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}