import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'HomePage.dart';

class Profilepage extends StatefulWidget {
  final String name;
  final String phone;
  final String email;

  Profilepage({Key? key, required this.name, required this.phone, required this.email}) : super(key: key);

  @override
  _ProfilepageState createState() => _ProfilepageState();
}

class _ProfilepageState extends State<Profilepage> {
  late TextEditingController nameController;
  late TextEditingController phoneController;
  late TextEditingController emailController;
  File? _imageFile;
  bool isEditing = true; // تعيين الوضع إلى التعديل عند تحميل الصفحة

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.name);
    phoneController = TextEditingController(text: widget.phone);
    emailController = TextEditingController(text: widget.email);
    _loadImage();
  }

  // تحميل الصورة المحفوظة سابقاً من SharedPreferences
  Future<void> _loadImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? imagePath = prefs.getString('profileImage');
    if (imagePath != null) {
      setState(() {
        _imageFile = File(imagePath);
      });
    }
  }

  // اختيار صورة جديدة من المعرض
  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
      _saveImage(pickedFile.path);  // حفظ المسار الجديد للصورة
    }
  }

  // حفظ الصورة الجديدة في SharedPreferences
  Future<void> _saveImage(String path) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('profileImage', path);
  }

  // حفظ البيانات النصية (اسم، هاتف، بريد) في SharedPreferences
  Future<void> _saveProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', nameController.text);
    await prefs.setString('phone', phoneController.text);
    await prefs.setString('email', emailController.text);
    
    // العودة إلى الصفحة الرئيسية مع البيانات المحفوظة
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HomePage(
          name: nameController.text,
          phone: phoneController.text,
          email: emailController.text,
        ),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Edit Profile", style: TextStyle(color: Colors.black)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            // العودة إلى الصفحة الرئيسية مع البيانات
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(
                  name: widget.name,
                  phone: widget.phone,
                  email: widget.email,
                ),
              ),
            );
          },
        ),
        actions: [
          IconButton(
            icon: Icon(isEditing ? Icons.save : Icons.edit, color: Colors.black),
            onPressed: () {
              // حفظ البيانات عند التعديل
              if (isEditing) {
                _saveProfile();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Profile updated successfully!")),
                );
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: _imageFile != null
                        ? FileImage(_imageFile!)
                        : const AssetImage('images/mm.png') as ImageProvider,
                  ),
                  if (isEditing)
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: InkWell(
                        onTap: _pickImage,
                        child: CircleAvatar(
                          backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                          radius: 20,
                          child: const Icon(
                            Icons.edit,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 20),
              // Name Field
              _buildTextField("Name", nameController),
              const SizedBox(height: 16),
              // Phone Field
              _buildTextField("Phone Number", phoneController, keyboardType: TextInputType.phone),
              const SizedBox(height: 16),
              // Email Field
              _buildTextField("Email", emailController),
            ],
          ),
        ),
      ),
    );
  }

  // Widget for common TextFormField
  Widget _buildTextField(String label, TextEditingController controller, {TextInputType keyboardType = TextInputType.text}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 16, color: Color.fromARGB(113, 0, 0, 0))),
        const SizedBox(height: 8),
        isEditing
            ? TextFormField(
                controller: controller,
                keyboardType: keyboardType,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color.fromARGB(82, 64, 64, 64),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                ),
              )
            : Container(
                padding: const EdgeInsets.all(12.0),
                margin: const EdgeInsets.only(top: 8),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  controller.text,
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                ),
              ),
      ],
    );
  }
}
