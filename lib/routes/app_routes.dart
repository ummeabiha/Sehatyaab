import 'package:flutter/material.dart';
import '../screens/PatientPanel/patient_form.dart';
import '../screens/PatientPanel/patient_medical_info_form.dart';
import '../screens/home_screen.dart';

class AppRoutes {
  static const String home = '/';
  static const String patientForm = '/patientForm';
  static const String patientMedicalInfoForm = '/patientMedicalInfoForm';

  static final Map<String, WidgetBuilder> routes = {
    home: (context) => const HomeScreen(),
    patientForm: (context) => const PatientForm(),
    patientMedicalInfoForm: (context) => const PatientMedicalInfoForm(
          patientData: {},
        ),
  };
}
