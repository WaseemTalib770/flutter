import 'package:flutter/material.dart';
import 'package:flutter_application_177/HomePage.dart';

class AboutPage extends StatefulWidget {
  final String name;
  final String phone;
  final String email;

  AboutPage({Key? key, required this.name, required this.phone, required this.email}) : super(key: key);

  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 252, 252, 252),
        title: const Text('About This App', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color.fromARGB(255, 0, 0, 0)),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(
                  name: widget.name,
                  phone: widget.phone,
                  email: widget.email,
                ),
              ),
            ); // العودة إلى الصفحة السابقة
          },
        ),
      ),
      
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16),
              // عنوان الصفحة
              const Text(
                'About This App',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 16),

              // وصف التطبيق
              const Text(
                'This app is designed to help users manage their profiles and contact information efficiently. It allows users to update their name, phone number, email, and profile picture easily. The application uses SharedPreferences to store user data and ensure a seamless experience across sessions.',
                style: TextStyle(fontSize: 16, height: 1.5),
              ),
              const SizedBox(height: 20),

              // مميزات التطبيق
              const Text(
                'Features:',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                '• Easy profile editing\n'
                '• Image picker for profile pictures\n'
                '• Store and retrieve data using SharedPreferences\n'
                '• Seamless user experience across sessions\n'
                '• Lightweight and efficient design',
                style: TextStyle(fontSize: 16, height: 1.5),
              ),
              const SizedBox(height: 20),

              // معلومات المطور
              const Text(
                'Developer:',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'App developed by [Your Name]\n'
                'Feel free to reach out for any feedback or suggestions!',
                style: TextStyle(fontSize: 16, height: 1.5),
              ),
              const SizedBox(height: 20),

              // روابط تواصل اجتماعي (إذا كان لديك)
              const Text(
                'Contact & Social Media:',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10),

              // النسخة الحالية
              const Divider(),
              const SizedBox(height: 10),
              const Text(
                'Version: 1.0.0',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
