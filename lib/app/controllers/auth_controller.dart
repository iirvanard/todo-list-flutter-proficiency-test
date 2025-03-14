// lib/app/controllers/auth_controller.dart
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/db_service.dart';
import '../models/user_model.dart';
import '../views/home_screen.dart';
import '../views/login_screen.dart';

class AuthController extends GetxController {
  var isLoggedIn = false.obs;
  var usernameController = TextEditingController();
  var passwordController = TextEditingController();

  Future<void> login() async {
    String username = usernameController.text.trim();
    String password = passwordController.text.trim();
    User? user = await DatabaseService.getUser(username);

    if (user != null && user.password == password) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('isLoggedIn', true);
      Get.offAll(() => HomeScreen());
    } else {
      Get.snackbar("Error", "Invalid Credentials");
    }
  }

  Future<void> register() async {
    String username = usernameController.text.trim();
    String password = passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      Get.snackbar("Error", "Fields cannot be empty");
      return;
    }

    User? existingUser = await DatabaseService.getUser(username);
    if (existingUser != null) {
      Get.snackbar("Error", "User already exists");
      return;
    }

    await DatabaseService.registerUser(
      User(username: username, password: password),
    );
    Get.snackbar("Success", "User Registered Successfully");
    Get.offAll(() => LoginScreen());
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', false);
    Get.offAll(() => LoginScreen());
  }
}
