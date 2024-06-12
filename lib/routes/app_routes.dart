import 'package:flutter/material.dart';
import 'package:sehatyaab/widgets/PatientPanel/patient_list.dart';
import '../screens/PatientPanel/patient_form.dart';
import '../screens/PatientPanel/patient_medical_info_form.dart';
import '../screens/home_screen.dart';
import '../../services/firestore_service.dart';
import '../../models/patient.dart';
import 'package:sehatyaab/Screens/Welcome/welcome_screen.dart';
import 'package:sehatyaab/screens/PatientPanel/patient_hs.dart';

class AppRoutes {
  static const String welcome = '/welcome';
  static const String patienthp = '/patienthp';
  static const String home = '/';
  static const String patientForm = '/patientForm';
  static const String patientMedicalInfoForm = '/patientMedicalInfoForm';
  static const String patientList = '/patientList';

  static final Map<String, WidgetBuilder> routes = {
    welcome: (context) => const WelcomeScreen(),
    patienthp: (context) => const PatientHomeScreen(),
    home: (context) => const HomeScreen(),
    patientForm: (context) => const PatientForm(),
    patientMedicalInfoForm: (context) => const PatientMedicalInfoForm(
          patientData: {},
        ),
    patientList: (context) {
      final firestoreService = FirestoreService<Patient>('/patients');
      return PatientList(firestoreService: firestoreService);
    },
  };
}
