import 'package:flutter/material.dart';
import 'package:sehatyaab/screens/BookedDoctorAppointment/BookedAppointment.dart';
import 'package:sehatyaab/screens/Profiles/PatientProfile.dart';
import '../globals.dart';
import '../models/Appointments.dart';
import '../models/Doctor.dart';
import '../models/Patient.dart';
import '../screens/DisplayAppointments/DisplayAppointments.dart';
import '../screens/CreateDoctorProfile/CreateDoctorProfile.dart';
import '../screens/Login/LoginScreen.dart';
import '../screens/PatientHome/PatientHome.dart';
import '../screens/Profiles/DoctorProfile.dart';
import '../screens/Signup/SignUpScreen.dart';
import '../screens/CreatePatientProfile/PatientHistory.dart';
import '../screens/Appointments/AppointmentForm.dart';
import '../screens/Appointments/AppointmentList.dart';
import '../screens/Doctors/DoctorDescription.dart';
import '../screens/Welcome/WelcomeScreen.dart';
import '../services/FirestoreService.dart';
import '../screens/DoctorList/DoctorList.dart';
import '../screens/SplashScreen/SplashScreen.dart';

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
  static const String doctorList = '/doctorList';
  static const String displayPatient = '/displayPatient';
  static const String doctorProfile = '/doctorProfile';
  static const String signup = '/signup';
  static const String login = '/login';
  static const String doctorlist = '/doctorList';
  static const String appointmentForm = '/appointmentform';
  static const String appointmentlist = '/appointmentlist';
  static const String splash = '/splash';
  static const String bookedAppointment = '/bookedAppointment';
  static const String patientProfile = '/patientProfile';
  static const String displayDoctorProfile = '/displayDoctorProfile';

  static final Map<String, WidgetBuilder> routes = {
    welcome: (context) => const WelcomeScreen(),
    signup: (context) => const SignUpScreen(),
    login: (context) => const LoginScreen(),
    splash: (context) => const SplashScreen(),
    appointmentForm: (context) => const AppointmentForm(
          selectedDoctor: '',
          selectedDoctorId: '',
        ),
    appointmentlist: (context) => const AppointmentList(),
    doctordesc: (context) {
      return DoctorDescriptionScreen(firestoreService: doctorFirestore);
    },
    patientHistory: (context) => const PatientHistory(
          patientData: {},
        ),
    doctorList: (context) {
      return DoctorList(firestoreService: doctorFirestore);
    },
    displayPatient: (context) {
      return DisplayAppointments(
          appointmentService: appointmentFirestore,
          patientService: patientFirestore,
          doctorId: globalDoctorId!);
    },
    doctorProfile: (context) {
      return CreateDoctorProfile(
        doctorData: {},
        firestoreService: doctorFirestore,
      );
    },
    patienthp: (context) {
      return PatientHomeScreen(firestoreService: doctorFirestore);
    },
    bookedAppointment: (context) {
      return const BookedAppointment();
    },
    patientProfile: (context) {
      return const PatientProfile();
    },
    displayDoctorProfile: (context) {
      return const DoctorProfile();
    }
  };
}
