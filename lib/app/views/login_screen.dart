import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_iirvanard/app/lib/colors.dart';
import '../controllers/auth_controller.dart';
import 'register_screen.dart';

class LoginScreen extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Login",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColors.main, // Gunakan warna main
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0, // Hilangkan shadow di AppBar
      ),
      backgroundColor: AppColors.main, // Background body menggunakan warna main
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 40), // Spacing di atas form
            // Logo atau Gambar (Opsional)
            Icon(Icons.account_circle, size: 100, color: Colors.white),
            SizedBox(height: 20),

            // Username Field
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              color: AppColors.secondary, // Gunakan warna secondary
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextField(
                  controller: authController.usernameController,
                  style: TextStyle(
                    color: AppColors.textPrimary,
                  ), // Gunakan warna textPrimary
                  decoration: InputDecoration(
                    hintText: "Username",
                    border: InputBorder.none,
                    hintStyle: TextStyle(
                      color: AppColors.textSecondary,
                    ), // Gunakan warna textSecondary
                    prefixIcon: Icon(
                      Icons.person,
                      color: AppColors.main,
                    ), // Gunakan warna main
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),

            // Password Field
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              color: AppColors.secondary, // Gunakan warna secondary
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextField(
                  controller: authController.passwordController,
                  style: TextStyle(
                    color: AppColors.textPrimary,
                  ), // Gunakan warna textPrimary
                  decoration: InputDecoration(
                    hintText: "Password",
                    border: InputBorder.none,
                    hintStyle: TextStyle(
                      color: AppColors.textSecondary,
                    ), // Gunakan warna textSecondary
                    prefixIcon: Icon(
                      Icons.lock,
                      color: AppColors.main,
                    ), // Gunakan warna main
                  ),
                  obscureText: true,
                ),
              ),
            ),
            SizedBox(height: 24),

            // Login Button
            SizedBox(
              width: double.infinity, // Tombol memenuhi lebar layar
              child: ElevatedButton(
                onPressed: authController.login,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.accent, // Gunakan warna accent
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  "Login",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),

            // Register TextButton
            TextButton(
              onPressed: () => Get.to(() => RegisterScreen()),
              child: Text(
                "Belum punya akun? Register",
                style: TextStyle(
                  color: Colors.white, // Gunakan warna putih untuk kontras
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
