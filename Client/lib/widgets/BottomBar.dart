import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  final selectedIndex;
  ValueChanged<int> onClicked;
  BottomBar({Key? key, this.selectedIndex, required this.onClicked}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Outages',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications),
          label: 'Notifications',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Settings',
        )
      ],
      currentIndex: selectedIndex,
      onTap: onClicked,
      selectedItemColor: Colors.pink,
      backgroundColor: Colors.white,
      unselectedItemColor: Colors.black,
    );
  }
}