import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_iirvanard/app/services/db_user_service.dart';
import '../models/user_model.dart';
import '../views/home_screen.dart';
import '../views/login_screen.dart';

class AuthController extends GetxController {
  var isLoggedIn = false.obs;
  var loggedInUser = Rx<User?>(null); // User yang sedang login
  var usernameController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    loadUserSession(); // Memuat sesi pengguna saat aplikasi dibuka
  }

  Future<void> login() async {
    String username = usernameController.text.trim();
    String password = passwordController.text.trim();
    User? user = await UserDatabaseService.getUserByUsername(username);

    if (user != null && user.password == password) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('isLoggedIn', true);
      prefs.setString('username', username); // Simpan username untuk sesi
      loggedInUser.value = user; // Simpan user yang sedang login
      isLoggedIn.value = true;
      Get.offAll(() => HomeScreen());
    } else {
      Get.snackbar(
        "Error",
        "Invalid Credentials",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> register() async {
    String username = usernameController.text.trim();
    String password = passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      Get.snackbar(
        "Error",
        "Fields cannot be empty",
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    User? existingUser = await UserDatabaseService.getUserByUsername(username);
    if (existingUser != null) {
      Get.snackbar(
        "Error",
        "User already exists",
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    await UserDatabaseService.registerUser(
      User(username: username, password: password),
    );
    Get.snackbar(
      "Success",
      "User Registered Successfully",
      snackPosition: SnackPosition.BOTTOM,
    );
    Get.offAll(() => LoginScreen());
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Hapus semua data sesi
    loggedInUser.value = null;
    isLoggedIn.value = false;
    Get.offAll(() => LoginScreen());
  }

  Future<void> loadUserSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString('username');
    if (username != null) {
      User? user = await UserDatabaseService.getUserByUsername(username);
      if (user != null) {
        loggedInUser.value = user;
        isLoggedIn.value = true;
      }
    }
  }
}
