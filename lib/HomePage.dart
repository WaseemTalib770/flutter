import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_application_177/EngineersPage.dart';
import 'package:flutter_application_177/%D9%90AboutPage.dart';
import 'package:flutter_application_177/OrdersPage.dart';
import 'package:flutter_application_177/ProfilePage.dart';
import 'package:flutter_application_177/SignUpScreen.dart';

class HomePage extends StatefulWidget {
  final String name;
  final String phone;
  final String email;

  HomePage({required this.name, required this.phone, required this.email});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0; // Current page index

  // List of pages
  late final List<Widget> _pages = [
    HomeScreen(name: widget.name, phone: widget.phone, email: widget.email),
    Orderspage(name: widget.name, phone: widget.phone, email: widget.email),
    AboutPage(name: widget.name, phone: widget.phone, email: widget.email),
    Profilepage(name: widget.name, phone: widget.phone, email: widget.email),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Order'),
          BottomNavigationBarItem(icon: Icon(Icons.info), label: 'About'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  final String name;
  final String phone;
  final String email;

  const HomeScreen({Key? key, required this.name, required this.phone, required this.email})
      : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
 final Map<String, GlobalKey> sectionKeys = {
    'Engineers': GlobalKey(),
    'Electricians': GlobalKey(),
    'Plumbers': GlobalKey(),
    'Carpenters': GlobalKey(),
  };

  // بيانات منفصلة لكل فئة
  final List<Map<String, String>> engineersItems = [
    {'name': 'Mechanical Engineer', 'image': 'images/1.jpg'},
    {'name': 'Civil Engineer', 'image': 'images/1.jpg'},
    {'name': 'Car Electricians', 'image': 'images/1.jpg'},
    {'name': 'Car Engineers', 'image': 'images/1.jpg'},
  ];

  final List<Map<String, String>> electriciansItems = [
    {'name': 'Home Electrician', 'image': 'images/1.jpg'},
    {'name': 'Industrial Electrician', 'image': 'images/1.jpg'},
    {'name': 'Industrial', 'image': 'images/1.jpg'},
  ];

  final List<Map<String, String>> plumbersItems = [
    {'name': 'Residential Plumber', 'image': 'images/1.jpg'},
    {'name': 'Commercial Plumber', 'image': 'images/1.jpg'},
  ];

  final List<Map<String, String>> carpentersItems = [
    {'name': 'Furniture Carpenter', 'image': 'images/1.jpg'},
    {'name': 'Construction Carpenter', 'image': 'images/1.jpg'},
  ];

  List<Map<String, String>> filteredItems = [];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      filterItems();
    });
  }
void scrollToSection(String section) {
    final key = sectionKeys[section];
    if (key != null) {
      Scrollable.ensureVisible(
        key.currentContext!,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }
  void filterItems() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      // إذا كان النص فارغًا، نعرض جميع العناصر
      if (query.isEmpty) {
        filteredItems = [];
      } else {
        // يتم دمج جميع العناصر للبحث
        List<Map<String, String>> allItems = [
          ...engineersItems,
          ...electriciansItems,
          ...plumbersItems,
          ...carpentersItems,
        ];

        filteredItems = allItems
            .where((item) => item['name']!.toLowerCase().contains(query))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        elevation: 2,
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu, color: Colors.grey[800]),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
        title: Container(
          height: 35,
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.3),
            borderRadius: BorderRadius.circular(20),
            border: Border(
              bottom: BorderSide(color: Colors.teal, width: 2),
            ),
          ),
          child: TextField(
            controller: _searchController,
            style: TextStyle(fontSize: 14),
            decoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: Icon(Icons.search, color: Colors.grey[600], size: 18),
              hintText: "Search...",
              hintStyle: TextStyle(fontSize: 12, color: Colors.grey[600]),
              contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            ),
          ),
        ),
      ),
      drawer: _buildDrawer(),
      body: Column(
        children: [
          SizedBox(height: 200, child: buildImageSlider()),
          SizedBox(height: 20),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                buildCategoryCard('Engineers', Colors.teal),
                buildCategoryCard('Electricians', Colors.blue),
                buildCategoryCard('Plumbers', Colors.orange),
                buildCategoryCard('Carpenters', Colors.red),
              ],
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: filteredItems.isEmpty
                    ? [
                        buildScrollableSection(context, 'Engineers', engineersItems),
                        buildScrollableSection(context, 'Electricians', electriciansItems),
                        buildScrollableSection(context, 'Plumbers', plumbersItems),
                        buildScrollableSection(context, 'Carpenters', carpentersItems),
                      ]
                    : [
                        buildScrollableSection(context, 'Search Results', filteredItems),
                      ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildImageSlider() {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        PageView(
          controller: PageController(),
          scrollDirection: Axis.horizontal,
          children: [
            Image.asset('images/1.jpg', width: double.infinity, height: 200, fit: BoxFit.cover),
            Image.asset('images/1.jpg', width: double.infinity, height: 200, fit: BoxFit.cover),
            Image.asset('images/1.jpg', width: double.infinity, height: 200, fit: BoxFit.cover),
          ],
        ),
        Positioned(
          bottom: 10,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ...List.generate(3, (index) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    shape: BoxShape.circle,
                  ),
                );
              }),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildCategoryCard(String name, Color color) {
    return GestureDetector(
      onTap: () {

        scrollToSection(name);



      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.2),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          name,
          style: TextStyle(
            color: color,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

 



  Widget buildScrollableSection(BuildContext context, String section, List<Map<String, String>> items) {
    return Padding(
      key: sectionKeys[section],
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            section,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: items
                  .map(
                    (item) => buildCardItem(item['name']!, item['image']!, context),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCardItem(String name, String image, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => EngineersPage(category: name,name: widget.name,phone:widget.phone,email: widget.email,)),
        ); 
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                image,
                width: 130,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 5),
            Text(
              name,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.teal,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, size: 40, color: Colors.teal),
                ),
                SizedBox(height: 10),
                Text(widget.name, style: TextStyle(fontSize: 20, color: Colors.white)),
                SizedBox(height: 5),
                Text(widget.email, style: TextStyle(fontSize: 14, color: Colors.white)),
                SizedBox(height: 5),
                Text(widget.phone, style: TextStyle(fontSize: 14, color: Colors.white)),
              ],
            ),
          ),
          ListTile(
            title: Text('Settings'),
            onTap: () {},
          ),
          ListTile(
            title: Text('Sign Out'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => SignUpScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
