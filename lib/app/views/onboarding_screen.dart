import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_iirvanard/app/lib/colors.dart';
import 'package:todo_iirvanard/app/views/login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, dynamic>> _onboardingData = [
    {
      "icon": Icons.person,
      "title": "Welcome!",
      "description": "Atur pekerjaanmu dengan mudah dan tetap produktif!",
      "color": AppColors.accent,
      "iconColor": Colors.white,
    },
    {
      "icon": Icons.work_outline,
      "title": "Manage Your Tasks",
      "description":
          "Tambah, edit, dan selesaikan tugas harianmu dengan cepat!",
      "color": AppColors.secondary,
      "iconColor": AppColors.accent,
    },
    {
      "icon": Icons.alarm,
      "title": "Never Miss a Task",
      "description": "Atur pengingat agar kamu tidak melewatkan tugas penting!",
      "color": AppColors.success,
      "iconColor": Colors.white,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.main,
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: _onboardingData.length,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemBuilder: (context, index) {
                return _buildPage(_onboardingData[index]);
              },
            ),
          ),
          _buildPageIndicator(),
          SizedBox(height: 20),
          _buildNavigationButton(),
          SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _buildPage(Map<String, dynamic> data) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 160,
            width: 160,
            decoration: BoxDecoration(
              color: data["color"].withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(data["icon"], size: 80, color: data["iconColor"]),
          ),
          SizedBox(height: 30),
          Text(
            data["title"],
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 15),
          Text(
            data["description"],
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.white70),
          ),
        ],
      ),
    );
  }

  Widget _buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(_onboardingData.length, (index) {
        return AnimatedContainer(
          duration: Duration(milliseconds: 300),
          margin: EdgeInsets.symmetric(horizontal: 5),
          width: _currentPage == index ? 16 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: _currentPage == index ? AppColors.accent : Colors.white70,
            borderRadius: BorderRadius.circular(8),
          ),
        );
      }),
    );
  }

  Widget _buildNavigationButton() {
    return _currentPage == _onboardingData.length - 1
        ? ElevatedButton(
          onPressed: () => Get.offAll(() => LoginScreen()),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.accent,
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          child: Text(
            "Get Started",
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        )
        : TextButton(
          onPressed: () {
            _pageController.nextPage(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          },
          child: Text(
            "Next",
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
        );
  }
}
