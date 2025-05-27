import 'package:bitnotes/login_screen.dart';
import 'package:get/get.dart';
import 'dart:async';

class SplashController extends GetxController {
  RxBool showBit = false.obs;
  RxBool showNotes = false.obs;
  RxBool showTagline = false.obs;

  @override
  void onInit() {
    super.onInit();
    startAnimation();
  }

  void startAnimation() async {
    await Future.delayed(Duration(milliseconds: 500));
    showBit.value = true;

    await Future.delayed(Duration(milliseconds: 800));
    showNotes.value = true;

    await Future.delayed(Duration(milliseconds: 1000));
    showTagline.value = true;

    await Future.delayed(Duration(seconds: 10));
    Get.offAll(() => LoginScreen()); // Navigate to Home Screen
  }
}
