import 'package:flutter/material.dart';
import 'package:flutter_application_177/AddEngineerPage.dart';
import 'package:flutter_application_177/EditEngineerPage.dart';
import 'package:flutter_application_177/OrdersPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class EngineersPage extends StatefulWidget {
  final String category;

  final String name;
  final String phone;
  final String email;

  EngineersPage({Key? key, required this.name, required this.phone, required this.email,required this.category}) : super(key: key);


  @override
  static List<Map<String, dynamic>> orders = []; 
  _EngineersPageState createState() => _EngineersPageState();
}

class _EngineersPageState extends State<EngineersPage> {
  List<Map<String, dynamic>> engineers = [];

  @override
  void initState() {
    super.initState();
    loadEngineers();
  }

  Future<void> loadEngineers() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? engineersString = prefs.getString(widget.category);
    if (engineersString != null) {
      List<dynamic> jsonList = json.decode(engineersString);
      engineers = List<Map<String, dynamic>>.from(jsonList);
    } else {
      // Default data if no saved data
      engineers = getDefaultEngineers();
    }
    setState(() {});
  }

  Future<void> saveEngineers() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(widget.category, json.encode(engineers));
  }

 Map<String, List<Map<String, dynamic>>> data = {
    'Car Engineers': [
      {
        'name': 'Engineer Ahmed',
        'location': 'Riyadh',
        'image': 'images/1.jpg',
        'rating': 4.5,
        'details': 'Expert in car maintenance for 10 years.',
      },
      {
        'name': 'Engineer Khalid',
        'location': 'Jeddah',
        'image': 'images/1.jpg',
        'rating': 4.0,
        'details': 'Specialized in electric car motors.',
      },
      {
        'name': 'Engineer Mohammed',
        'location': 'Dammam',
        'image': 'images/1.jpg',
        'rating': 4.7,
        'details': 'Specialized in car cooling and air conditioning.',
      },
    ],
    'Car Electricians': [
      {
        'name': 'Electrician Ali',
        'location': 'Mecca',
        'image': 'images/1.jpg',
        'rating': 4.2,
        'details': 'Specialized in lighting systems and electrical circuits.',
      },
      {
        'name': 'Electrician Hussain',
        'location': 'Jeddah',
        'image': 'images/1.jpg',
        'rating': 3.8,
        'details': 'Experienced in car electrical maintenance.',
      },
    ],
  };

  List<Map<String, dynamic>> getDefaultEngineers() {
    return [
      {
         
        'name': 'Engineer Ahmed',
        'location': 'Riyadh',
        'details': 'Expert in car maintenance for 10 years.',
        'rating': 4.5,
      },
      {
        'name': 'Engineer Khalid',
        'location': 'Jeddah',
        'details': 'Specialized in electric car motors.',
        'rating': 4.0,
      },
      {
        'name': 'Engineer Mohammed',
        'location': 'Dammam',
        'details': 'Specialized in car cooling and air conditioning.',
        'rating': 4.7,
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        elevation: 0,
        title: Text(widget.category, style: TextStyle(color: Colors.black)),
        iconTheme: IconThemeData(color: Colors.black),
        actions: [
          IconButton(
            icon: Icon(Icons.list, color: Colors.black),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Orderspage(name: widget.name,
                  phone: widget.phone,
                  email: widget.email,)),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: engineers.length,
        itemBuilder: (context, index) {
          final engineer = engineers[index];
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.grey[300],
                child: Icon(Icons.person, color: const Color.fromARGB(255, 176, 12, 12)),
              ),
              title: Text(engineer['name']),
              subtitle: Text(engineer['location']),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit, color: Colors.blue),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditEngineerPage(
                            engineer: engineer,
                            onSave: (updatedEngineer) {
                              setState(() {
                                engineers[index] = updatedEngineer;
                                saveEngineers();
                              });
                            },
                          ),
                        ),
                      );
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      setState(() {
                        engineers.removeAt(index);
                        saveEngineers();
                      });
                    },
                  ),
                ],
              ),
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  builder: (context) {
                    TextEditingController problemController = TextEditingController();
                    return FractionallySizedBox(
                      heightFactor: 0.8,
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              engineer['name'],
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 8),
                                                        Text(
                              engineer['details'],
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(height: 16),
                            TextField(
                              controller: problemController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Describe the problem here...',
                              ),
                              maxLines: 2,
                            ),
                            SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () {
                                if (problemController.text.isNotEmpty) {
                                  EngineersPage.orders.add({
                                    'name': engineer['name'],
                                    'problem': problemController.text,
                                    'location': engineer['location'],
                                  });
                                  Navigator.pop(context);
                                }
                              },
                              child: Text("Send"),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddEngineerPage(
                onSave: (newEngineer) {
                  setState(() {
                    engineers.add(newEngineer);
                    saveEngineers();
                  });
                },
              ),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

