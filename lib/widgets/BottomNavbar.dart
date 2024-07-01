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
        Navigator.pushReplacementNamed(context, '/doctorList');
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/bookedAppointment');
        break;
      case 3:
        Navigator.pushReplacementNamed(context, '/doctordesc');
        break;
    }
  }

  int _getCurrentIndex(String? routeName) {
    switch (routeName) {
      case AppRoutes.patienthp:
        return 0;
      case '/doctorList':
        return 1;
      case '/bookedAppointment':
        return 2;
      case '/doctordesc':
        return 3;
      default:
        return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentRoute = ModalRoute.of(context)?.settings.name;
    final int selectedIndex = _getCurrentIndex(currentRoute);

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
          _buildNavItem(Icons.home, 'Home', 0, context, selectedIndex),
          _buildNavItem(
              Icons.medical_services, 'Doctors', 1, context, selectedIndex),
          _buildNavItem(
              Icons.event_note, 'Scheduled', 2, context, selectedIndex),
          _buildNavItem(
              Icons.menu_book_rounded, 'Book', 3, context, selectedIndex),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index,
      BuildContext context, int selectedIndex) {
    final isSelected = selectedIndex == index;
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
                color: isSelected
                    ? AppColors.pink
                    : Theme.of(context).primaryColor,
                fontSize: 14.0),
          ),
        ],
      ),
    );
  }
}
