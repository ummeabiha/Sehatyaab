import 'dart:js';

import 'package:flutter/material.dart';
import 'package:sehatyaab/Screens/Welcome/WelcomeScreen.dart';
import 'package:sehatyaab/models/appointments.dart';
import 'package:sehatyaab/models/doctor.dart';
import 'package:sehatyaab/screens/DoctorProfile/CreateDoctorProfile.dart';
import 'package:sehatyaab/screens/Login/LoginScreen.dart';
import 'package:sehatyaab/screens/PatientAppointments/DisplayPatients.dart';
import 'package:sehatyaab/screens/PatientHome/PatientHome.dart';
import 'package:sehatyaab/screens/Signup/SignUpScreen.dart';
import 'package:sehatyaab/widgets/patient_list.dart';
import '../screens/PatientProfile/CreatePatientProfile.dart';
import '../screens/PatientProfile/PatientHistory.dart';
import '../screens/home_screen.dart';
import '../screens/Appointments/AppointmentForm.dart';
import '../screens/Appointments/appointment_list.dart';

import '../screens/Doctors/Doctor_description.dart';
// import '../..services/FirestoreService.dart';
import '../services/FirestoreService.dart';~
import '../models/Patient.dart';

final doctorFirestore = FirestoreService<Doctor>('/doctors');
final patientFirestore = FirestoreService<Patient>('/patients');
final appointmentFirestore = FirestoreService<Appointment>('/appointments');

class AppRoutes {
  static const String welcome = '/welcome';
  static const String patienthp = '/patienthp';
  static const String home = '/';
  static const String doctordesc = '/doctordesc';
  static const String patientForm = '/patientForm';
  static const String patientHistory = '/patientHistory';
  static const String patientList = '/patientList';
  static const String displayPatient = '/displayPatient';
  static const String doctorProfile = '/doctorProfile';
  static const String signup = '/signup';
  static const String login = '/login';
  static const String appointmentForm = '/appointmentform';
  static const String appointmentlist = '/appointmentlist';

  static final Map<String, WidgetBuilder> routes = {
    welcome: (context) => const WelcomeScreen(),
    signup: (context) => const SignUpScreen(),
    login: (context) => const LoginScreen(),
    //patienthp: (context) => const PatientHomeScreen(),
    home: (context) => const HomeScreen(),

    // doctordesc: (context) => DoctorDescriptionScreen(firestoreService: firestoreService),
    appointmentForm: (context) => AppointmentForm(
      selectedDoctor: '',
      selectedDoctorId: '',

    ),

    appointmentlist: (context) => AppointmentList(),

    patientForm: (context) => const CreatePatientProfile(),
    doctordesc: (context) {
      final firestoreService = FirestoreService<Doctor>('/doctordesc');
      return DoctorDescriptionScreen(firestoreService: firestoreService);
    },


    patientHistory: (context) => const PatientHistory(
          patientData: {},
        ),
    patientList: (context) {
      return PatientList(firestoreService: patientFirestore);
    },

    // displayPatient: (context) {
    //   return DisplayPatients(
    //       appointmentService: appointmentFirestore,
    //       patientService: patientFirestore,
    //       doctorId: 'app1');
    // },
    //
    // doctorProfile: (context) {
    //   return CreateDoctorProfile(
    //     doctorData: {},
    //     firestoreService: doctorFirestore,
    //   );
    // },
    //
    // patienthp: (context) {
    //   return PatientHomeScreen(firestoreService: doctorFirestore);
    // },
  };
}
