// lib/app/views/onboarding_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_iirvanard/app/views/login_screen.dart';

class OnboardingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () => Get.offAll(() => LoginScreen()),
          child: Text("Get Started"),
        ),
      ),
    );
  }
}
