import 'package:flutter/material.dart';
import 'package:intelliface/screens/home.dart';
import 'package:intelliface/screens/login.dart';
import 'package:intelliface/screens/profile.dart';
import 'package:intelliface/screens/classes.dart';
import 'package:intelliface/screens/home.dart';
import 'package:sliding_clipped_nav_bar/sliding_clipped_nav_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Intelliface',
      theme: ThemeData(fontFamily: 'Poppins', primarySwatch: Colors.blue),
      home: MainNavigationPage(),
    );
  }
}

class MainNavigationPage extends StatefulWidget {
  const MainNavigationPage({super.key});

  @override
  State<MainNavigationPage> createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage> {
  int selectedIndex = 0;
  late PageController controller;

  final List<Widget> pages = [
    HomePage(),
    ProfessorScreen(),
    ProfileScreen(),
  ];

  @override
  void initState() {
    controller = PageController(initialPage: selectedIndex);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: controller,
        children: pages,
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 10.0), // Adjust padding as needed
          child: SlidingClippedNavBar(
            backgroundColor: Colors.white,
            onButtonPressed: (index) {
              if (!mounted) return;
              setState(() {
                selectedIndex = index;
              });
              controller.animateToPage(
                index,
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeOutQuad,
              );
            },
            iconSize: 30,
            activeColor: const Color(0xFF01579B),
            selectedIndex: selectedIndex,
            barItems: [
              BarItem(
                icon: Icons.home,
                title: 'Home',
              ),
              BarItem(
                icon: Icons.event,
                title: 'Class',
              ),
              BarItem(
                icon: Icons.person,
                title: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
