import 'dart:js';

import 'package:flutter/material.dart';
import 'package:sehatyaab/Screens/Welcome/WelcomeScreen.dart';
import 'package:sehatyaab/models/doctor.dart';
import 'package:sehatyaab/screens/PatientHome/PatientHome.dart';
import 'package:sehatyaab/widgets/patient_list.dart';
import '../screens/PatientProfile/CreatePatientProfile.dart';
import '../screens/PatientProfile/PatientHistory.dart';
import '../screens/home_screen.dart';
import '../screens/Appointments/AppointmentForm.dart';
import '../screens/Appointments/appointment_list.dart';

import '../screens/Doctors/Doctor_description.dart';
import '../services/FirestoreService.dart';
import '../../models/patient.dart';

class AppRoutes {
  static const String welcome = '/welcome';
  static const String patienthp = '/patienthp';
  static const String home = '/';
  static const String doctordesc='/doctordesc';
  static const String patientForm = '/patientForm';
  static const String patientHistory = '/patientHistory';
  static const String patientList = '/patientList';
  static const String appointmentForm = '/appointmentform';
  static const String appointmentlist = '/appointmentlist';

  static final Map<String, WidgetBuilder> routes = {
    welcome: (context) => const WelcomeScreen(),
    //patienthp: (context) => const PatientHomeScreen(),
    home: (context) => const HomeScreen(),
    // doctordesc: (context) => DoctorDescriptionScreen(firestoreService: firestoreService),
    appointmentForm: (context) => AppointmentForm(
      selectedDoctor: '',
      firestoreService: FirestoreService<Doctor>('/doctors'),
    ),
    appointmentlist:(context)=>AppointmentList(),
    patientForm: (context) => const CreatePatientProfile(),
    doctordesc: (context) {
      final firestoreService = FirestoreService<Doctor>('/doctordesc');
      return DoctorDescriptionScreen(firestoreService: firestoreService);
    },

    patientHistory: (context) => const PatientHistory(
          patientData: {},
        ),
    patientList: (context) {
      final firestoreService = FirestoreService<Patient>('/patients');
      return PatientList(firestoreService: firestoreService);
    },
    patienthp: (context) {
      final firestoreService = FirestoreService<Doctor>('/doctors');
      return PatientHomeScreen(firestoreService: firestoreService);
    },
  };
}
