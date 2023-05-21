import 'package:flutter/material.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          currentIndex: 4,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.shopping_basket_outlined), label: 'Menu2'),
            BottomNavigationBarItem(icon: Icon(Icons.account_balance_sharp), label: 'Menu2'),
            BottomNavigationBarItem(icon: Icon(Icons.event_available_sharp), label: 'Menu2'),
            BottomNavigationBarItem(icon: Icon(Icons.calendar_month), label: 'Menu2'),
            BottomNavigationBarItem(icon: Icon(Icons.account_circle_outlined), label: 'Profile'),
          ],
        );
  }
}




