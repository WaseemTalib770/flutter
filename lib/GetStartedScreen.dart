import 'package:flutter/material.dart';
import 'package:flutter_application_177/LoginScreen.dart';

class Getstartedscreen extends StatelessWidget {
  const Getstartedscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // خلفية الشاشة
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: Text(
                '', // يمكن ترك النص فارغاً أو إضافة عناصر تصميم أخرى لاحقًا
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white, // لون الخلفية الأبيض
                    foregroundColor: Colors.black, // لون النص الأسود
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(color: Colors.black),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  ),
                  onPressed: () {
                    Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
                  },
                  child: Text(
                    'Get Started .',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}