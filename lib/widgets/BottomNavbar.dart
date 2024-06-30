import 'package:flutter/material.dart';
import '../routes/AppRoutes.dart';
import '../theme/AppColors.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const BottomNavBar({
    required this.currentIndex,
    required this.onTap,
    super.key,
  });

  void _navigate(int index, BuildContext context) {
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, AppRoutes.patienthp);
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/doctorList');
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/doctorList');
        break;
      case 3:
        Navigator.pushReplacementNamed(context, '/doctorList');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(0, -1),
            blurRadius: 6.0,
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(Icons.home, 'Home', 0, context),
          _buildNavItem(Icons.medical_services, 'Doctors', 1, context),
          _buildNavItem(Icons.event_note, 'Patients', 2, context),
          _buildNavItem(Icons.menu_book_rounded, 'Profile', 3, context),
        ],
      ),
    );
  }

  Widget _buildNavItem(
      IconData icon, String label, int index, BuildContext context) {
    final isSelected = currentIndex == index;
    return GestureDetector(
      onTap: () {
        onTap(index);
        _navigate(index, context);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon,
              color:
                  isSelected ? AppColors.pink : Theme.of(context).primaryColor,
              size: 24.0),
          const SizedBox(height: 4),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).primaryColor, fontSize: 14.0),
          ),
        ],
      ),
    );
  }
}
