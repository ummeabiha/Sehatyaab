import 'package:flutter/material.dart';
import 'package:sehatyaab/Screens/Welcome/WelcomeScreen.dart';
import 'package:sehatyaab/globals.dart';
import 'package:sehatyaab/models/appointments.dart';
import 'package:sehatyaab/models/Doctor.dart';
import 'package:sehatyaab/screens/DoctorProfile/CreateDoctorProfile.dart';
import 'package:sehatyaab/screens/Login/LoginScreen.dart';
import 'package:sehatyaab/screens/PatientAppointments/DisplayAppointments.dart';
import 'package:sehatyaab/screens/PatientHome/PatientHome.dart';
import 'package:sehatyaab/screens/Signup/SignUpScreen.dart';
import 'package:sehatyaab/widgets/patient_list.dart';
import '../screens/PatientProfile/CreatePatientProfile.dart';
import '../../screens/PatientProfile/PatientHistory.dart';
import '../screens/Appointments/AppointmentForm.dart';
import '../screens/Appointments/appointment_list.dart';

import '../screens/Doctors/Doctor_description.dart';
import '../services/FirestoreService.dart';
import '../models/Patient.dart';
import 'package:sehatyaab/screens/DoctorList/DoctorList.dart';
import 'package:sehatyaab/Providers/appointment_provider.dart';

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
  static const String doctorlist = '/doctorList';
  static const String appointmentForm = '/appointmentform';
  static const String appointmentlist = '/appointmentlist';

  static final Map<String, WidgetBuilder> routes = {
    welcome: (context) => const WelcomeScreen(),
    signup: (context) => const SignUpScreen(),
    login: (context) => const LoginScreen(),
    //patienthp: (context) => const PatientHomeScreen(),


    appointmentForm: (context) => AppointmentForm(
          selectedDoctor: '',
          selectedDoctorId: '',
        ),
    appointmentlist: (context) => AppointmentList(),

    doctordesc: (context) {
      final firestoreService = FirestoreService<Doctor>('/doctordesc');
      return DoctorDescriptionScreen(firestoreService: doctorFirestore);
    },

    patientHistory: (context) => const PatientHistory(
          patientData: {},
        ),
    patientList: (context) {
      return PatientList(firestoreService: patientFirestore);
    },

    // displayPatient: (context) {
    //   return DisplayAppointments(
    //       appointmentService: appointmentFirestore,
    //       patientService: patientFirestore,
    //       doctorId: globalDoctorId!);
    // },

    doctorProfile: (context) {
      return CreateDoctorProfile(
        doctorData: {},
        firestoreService: doctorFirestore,
      );
    },

    patienthp: (context) {
      return PatientHomeScreen(firestoreService: doctorFirestore);
    },
    doctorlist: (context) {
      return DoctorList(firestoreService: doctorFirestore);
    }
  };
}
