import 'package:flutter/material.dart';
import 'package:sehatyaab/constants.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  void _onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/');
        break;
      case 1:
        Navigator.pushNamed(context, '/appointments');
        break;
      case 2:
        Navigator.pushNamed(context, '/doctors');
        break;
      case 3:
        Navigator.pushNamed(context, '/patientForm');
        break;
    }
    onTap(index);
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) => _onItemTapped(context, index),
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home,
              color: currentIndex == 0 ? navyBlue : Colors.grey),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_today,
              color: currentIndex == 1 ? navyBlue : Colors.grey),
          label: 'Appointments',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person,
              color: currentIndex == 2 ? navyBlue : Colors.grey),
          label: 'Doctors',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person,
              color: currentIndex == 3 ? navyBlue : Colors.grey),
          label: 'Profile',
        ),
      ],
    );
  }
}
