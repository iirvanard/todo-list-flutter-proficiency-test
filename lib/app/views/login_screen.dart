// lib/app/views/login_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import 'register_screen.dart';

class LoginScreen extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Column(
        children: [
          TextField(
            controller: authController.usernameController,
            decoration: InputDecoration(hintText: "Username"),
          ),
          TextField(
            controller: authController.passwordController,
            decoration: InputDecoration(hintText: "Password"),
            obscureText: true,
          ),
          ElevatedButton(onPressed: authController.login, child: Text("Login")),
          TextButton(
            onPressed: () => Get.to(() => RegisterScreen()),
            child: Text("Register"),
          ),
        ],
      ),
    );
  }
}
