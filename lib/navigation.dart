import 'package:flutter/material.dart';
import 'package:ta_ppb/pages/home.dart';
import 'package:ta_ppb/pages/profile.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _pages[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: [
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(bottom: 0),
                child: Image.asset(
                  _selectedIndex == 0
                      ? 'assets/HomeLogo.png'
                      : 'assets/HomeLogoGrey.png',
                  height: 36,
                ),
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Icon(
                  Icons.person,
                  color: _selectedIndex == 1 ? Colors.black : Colors.grey,
                ),
              ),
              label: 'Profile',
            ),
          ],
          selectedLabelStyle: const TextStyle(
            fontSize: 14,
            fontFamily: 'MonsalGothic',
          ),
          unselectedLabelStyle: const TextStyle(
            fontSize: 12,
            fontFamily: 'MonsalGothic',
          ),
        ));
  }
}
