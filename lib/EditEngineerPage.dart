import 'package:flutter/material.dart';

class EditEngineerPage extends StatefulWidget {
  final Map<String, dynamic> engineer;
  final Function(Map<String, dynamic>) onSave;

  EditEngineerPage({required this.engineer, required this.onSave});

  @override
  _EditEngineerPageState createState() => _EditEngineerPageState();
}

class _EditEngineerPageState extends State<EditEngineerPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController detailsController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.engineer['name'];
    locationController.text = widget.engineer['location'];
    detailsController.text = widget.engineer['details'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit Engineer')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Name is required';
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
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final updatedEngineer = {
                      'name': nameController.text.trim(),
                      'location': locationController.text.trim(),
                      'details': detailsController.text.trim(),
                      'rating': widget.engineer['rating'],
                    };
                    widget.onSave(updatedEngineer);
                    Navigator.pop(context);
                  }
                },
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}