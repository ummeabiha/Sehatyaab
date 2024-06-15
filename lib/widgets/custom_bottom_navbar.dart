import 'package:flutter/material.dart';
import 'package:sehatyaab/constants.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({super.key, 
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) {
        onTap(index);
      },
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
