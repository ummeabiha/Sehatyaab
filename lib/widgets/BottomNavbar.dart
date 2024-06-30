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
        Navigator.pushNamed(context, AppRoutes.patienthp);
        break;
      case 1:
        Navigator.pushNamed(context, '/doctorList');
        break;
      case 2:
        Navigator.pushNamed(context, '/displayPatient');
        break;
      case 3:
        Navigator.pushNamed(context, '/doctorProfile');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(0, -1),
            blurRadius: 6.0,
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(
          vertical: 12.0, horizontal: 12.0), // Add padding
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(Icons.home, 'Home', 0, context),
          _buildNavItem(Icons.medical_services, 'Doctors', 1, context),
          _buildNavItem(Icons.person, 'Patients', 2, context),
          _buildNavItem(Icons.person_outline, 'Profile', 3, context),
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
