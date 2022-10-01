import 'package:flutter/material.dart';
import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:tronicassociates/screens/HomeScreen.dart';
import 'package:tronicassociates/screens/commercial.dart';
import 'package:tronicassociates/screens/description.dart';
import 'package:tronicassociates/screens/industrial.dart';
import 'package:tronicassociates/screens/profile.dart';
import 'package:tronicassociates/screens/residential.dart';
import 'package:tronicassociates/screens/upload.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  List<Widget> tabItems = [
    HomeScreen(),
    Industrial(),
    Commercial(),
    Residential(),
    Center(child: Text("Info Page")),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Upload()))
        },
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: FlashyTabBar(
        selectedIndex: _selectedIndex,
        showElevation: true,
        onItemSelected: (index) => setState(() {
          _selectedIndex = index;
        }),
        items: [
          FlashyTabBarItem(
            icon: Icon(Icons.home_work_outlined),
            title: Text('Home'),
          ),
          FlashyTabBarItem(
            icon: Icon(Icons.real_estate_agent_rounded),
            title: Text('Indus'),
          ),
          FlashyTabBarItem(
            icon: Icon(Icons.shopping_cart_sharp),
            title: Text('Comm'),
          ),
          FlashyTabBarItem(
            icon: Icon(Icons.home_max_sharp),
            title: Text('Resid'),
          ),
          FlashyTabBarItem(
            icon: Icon(Icons.info_rounded),
            title: Text('Info'),
          ),
        ],
      ),
      body: tabItems[_selectedIndex],
    );
  }
}
