import 'package:flutter/material.dart';

class AddEngineerPage extends StatefulWidget {
  final Function(Map<String, dynamic>) onSave;

  AddEngineerPage({required this.onSave});

  @override
  _AddEngineerPageState createState() => _AddEngineerPageState();
}

class _AddEngineerPageState extends State<AddEngineerPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController detailsController = TextEditingController();

  final _formKey = GlobalKey<FormState>(); // مفتاح النموذج

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Engineer')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey, // ربط المفتاح بالنموذج
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Name is required';
                  }
                  if (value.trim().length < 3) {
                    return 'Name must be at least 3 characters long';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: locationController,
                decoration: InputDecoration(labelText: 'Location'),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Location is required';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: detailsController,
                decoration: InputDecoration(labelText: 'Details'),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Details are required';
                  }
                  if (value.trim().length < 10) {
                    return 'Details must be at least 10 characters long';
                  }
                  return null;
                },
              ),
              SizedBox(height: 32),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // يتم الحفظ فقط إذا كانت الحقول صالحة
                      final newEngineer = {
                        'name': nameController.text.trim(),
                        'location': locationController.text.trim(),
                        'details': detailsController.text.trim(),
                        'rating': 4.0, // Default rating
                      };
                      widget.onSave(newEngineer);

                      Navigator.pop(context); // العودة إلى الشاشة السابقة
                    }
                  },
                  child: Text('Save Engineer'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
