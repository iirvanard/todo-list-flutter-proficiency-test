// lib/app/views/register_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import 'login_screen.dart';

class RegisterScreen extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Register")),
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
          ElevatedButton(
            onPressed: authController.register,
            child: Text("Register"),
          ),
          TextButton(
            onPressed: () => Get.to(() => LoginScreen()),
            child: Text("Back to Login"),
          ),
        ],
      ),
    );
  }
}
