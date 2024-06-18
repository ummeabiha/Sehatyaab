import 'package:flutter/material.dart';
import 'package:sehatyaab/Screens/Welcome/WelcomeScreen.dart';
import 'package:sehatyaab/models/Doctor.dart';
import 'package:sehatyaab/screens/DoctorProfile/CreateDoctorProfile.dart';
import 'package:sehatyaab/screens/Login/LoginScreen.dart';
import 'package:sehatyaab/screens/PatientHome/PatientHome.dart';
import 'package:sehatyaab/screens/Signup/SignUpScreen.dart';
import 'package:sehatyaab/widgets/patient_list.dart';
import '../screens/PatientProfile/CreatePatientProfile.dart';
import '../screens/PatientProfile/PatientHistory.dart';
import '../screens/home_screen.dart';
import '../services/FirestoreService.dart';
import '../models/Patient.dart';

class AppRoutes {
  static const String welcome = '/welcome';
  static const String patienthp = '/patienthp';
  static const String home = '/home';
  static const String patientForm = '/patientForm';
  static const String patientHistory = '/patientHistory';
  static const String patientList = '/patientList';
  static const String doctorProfile = '/doctorProfile';
  static const String signup = '/signup';
  static const String login = '/login';

  static final Map<String, WidgetBuilder> routes = {
    welcome: (context) => const WelcomeScreen(),
    signup: (context) => const  SignUpScreen(),
    login: (context) => const  LoginScreen(),
    //patienthp: (context) => const PatientHomeScreen(),
    home: (context) => const HomeScreen(),
    patientForm: (context) => const CreatePatientProfile(),
    patientHistory: (context) => const PatientHistory(
          patientData: {},
        ),
    patientList: (context) {
      final firestoreService = FirestoreService<Patient>('/patients');
      return PatientList(firestoreService: firestoreService);
    },

    doctorProfile: (context) {
      final firestoreService = FirestoreService<Doctor>('/doctors');
      return CreateDoctorProfile(
        doctorData: {},
        firestoreService: firestoreService,
      );
    },

    patienthp: (context) {
      final firestoreService = FirestoreService<Doctor>('/doctors');
      return PatientHomeScreen(firestoreService: firestoreService);
    },
  };
}
