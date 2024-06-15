import 'package:flutter/material.dart';
import 'package:sehatyaab/routes/AppRoutes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sehatyaab Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.patientForm);
              },
              child: const Text('Give Patient Data'),
            ),
            const SizedBox(height: 20), // Add some space between buttons
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.patientList);
              },
              child: const Text('View Patient List'),
            ),
          ],
        ),
      ),
    );
  }
}
