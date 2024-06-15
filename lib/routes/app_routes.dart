import 'package:flutter/material.dart';
import 'package:sehatyaab/widgets/patient_list.dart';
import '../screens/PatientProfile/CreatePatientProfile.dart';
import '../screens/PatientProfile/PatientHistory.dart';
import '../screens/home_screen.dart';
import '../../services/firestore_service.dart';
import '../../models/patient.dart';
import 'package:sehatyaab/Screens/Welcome/welcome_screen.dart';

class AppRoutes {
  static const String welcome = '/welcome';
  static const String home = '/';
  static const String patientForm = '/patientForm';
  static const String patientHistory = '/patientHistory';
  static const String patientList = '/patientList';

  static final Map<String, WidgetBuilder> routes = {
    welcome: (context) => const WelcomeScreen(),
    home: (context) => const HomeScreen(),
    patientForm: (context) => const CreatePatientProfile(),
    patientHistory: (context) => const PatientHistory(
          patientData: {},
        ),
    patientList: (context) {
      final firestoreService = FirestoreService<Patient>('/patients');
      return PatientList(firestoreService: firestoreService);
    },
  };
}
