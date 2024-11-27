import 'package:flutter/material.dart';
import 'package:flutter_application_177/EngineersPage.dart';
import 'package:flutter_application_177/HomePage.dart';

class Orderspage extends StatefulWidget {
  final String name;
  final String phone;
  final String email;

  Orderspage({Key? key, required this.name, required this.phone, required this.email}) : super(key: key);

  @override
  _OrderspageState createState() => _OrderspageState();
}

class _OrderspageState extends State<Orderspage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Orders'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
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
      ),
      body: ListView.builder(
        itemCount: EngineersPage.orders.length,
        itemBuilder: (context, index) {
          final order = EngineersPage.orders[index];
          return Card(
            margin: EdgeInsets.all(10),
            child: ListTile(
              title: Text("Name: ${order['name']}"),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Problem: ${order['problem']}"),
                  Text("Location: ${order['location']}"),
                ],
              ),
              trailing: IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  // حذف الطلب من القائمة
                  setState(() {
                    EngineersPage.orders.removeAt(index);
                  });
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
