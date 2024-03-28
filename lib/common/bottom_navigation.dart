import 'package:flutter/material.dart';
import 'package:story_apps/ui/add_story_page.dart';
import 'package:story_apps/ui/home_page.dart';
import 'package:story_apps/ui/profile_page.dart';

class CustomBottomNavigation extends StatefulWidget {
  const CustomBottomNavigation({super.key});

  @override
  State<CustomBottomNavigation> createState() => _CustomBottomNavigationState();
}

class _CustomBottomNavigationState extends State<CustomBottomNavigation> {
  int _bottomNavIndex = 2;

  final List<BottomNavigationBarItem> _navBarItems = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.add_box_outlined),
      label: 'Upload',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: 'Profile',
    ),
  ];

  final List<Widget> _listPage = [
    const HomePage(),
    const AddStoryPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _listPage[_bottomNavIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _bottomNavIndex,
        items: _navBarItems,
        unselectedItemColor: Colors.grey,
        selectedIconTheme: const IconThemeData(
          color: Colors.black,
        ),
        showSelectedLabels: true,
        showUnselectedLabels: true,
        unselectedLabelStyle: const TextStyle(
          color: Colors.grey,
        ),
        selectedItemColor: Colors.black,
        onTap: (value) {
          setState(() {
            _bottomNavIndex = value;
          });
        },
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
