import 'package:flutter/material.dart';
import 'PatientPanel/patient_form.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sehatyaab Home Page'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const PatientForm()),
            );
          },
          child: const Text('View Patient Data'),
        ),
      ),
    );
  }
}
