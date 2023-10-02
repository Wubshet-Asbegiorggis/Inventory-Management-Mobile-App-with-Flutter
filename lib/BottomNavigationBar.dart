import 'package:flutter/material.dart';
import 'package:inventory/HomeScreen.dart';
import 'package:inventory/ItemsList.dart';
import 'package:inventory/profileScreen.dart';
import 'package:inventory/reporScreen.dart';

class BottomNavigationScreen extends StatefulWidget {
  const BottomNavigationScreen({super.key});
  @override
  _BottomNavigationScreenState createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const ItemsScreen(),
    ReportPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        bucket: PageStorageBucket(), // Use a custom PageStorageBucket
        child: _screens[_currentIndex],
      ),
      bottomNavigationBar: SizedBox(
        child: Container(
          decoration: const BoxDecoration(
              border: Border(
                  top: BorderSide(
                      width: 2, color: Color.fromRGBO(107, 59, 225, 1)))),
          child: BottomNavigationBar(
            showUnselectedLabels: true,
            currentIndex: _currentIndex,
            selectedItemColor: const Color.fromRGBO(107, 11, 232, 1),
            unselectedItemColor: const Color.fromRGBO(107, 59, 225, 1),
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            iconSize: 31,
            unselectedFontSize: 14,
            selectedFontSize: 16,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                  ),
                  label: "Home"),
              BottomNavigationBarItem(
                icon: Icon(Icons.inventory_2_rounded),
                label: 'Items',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.data_object_outlined),
                label: 'Report',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_circle),
                label: 'User',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
