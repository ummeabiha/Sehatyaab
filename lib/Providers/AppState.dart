// import 'package:flutter/material.dart';
// import 'package:sehatyaab/models/Appointments.dart';
// import 'package:sehatyaab/services/FirestoreService.dart';

// class AppState extends ChangeNotifier {
//   bool _isAppBooked = false;

//   bool get isAppBooked => _isAppBooked;

//   set isAppBooked(bool value) {
//     _isAppBooked = value;
//     notifyListeners();
//   }

//   final FirestoreService<Appointment> _appointmentService =
//       FirestoreService<Appointment>('appointments');

//   void fetchAppointments(String patientId) {
//     _appointmentService
//         .getItemsByPatientIdStream(
//             patientId,
//             Appointment(
//               id: '',
//               date: '',
//               time: '',
//               patientId: '',
//               doctorId: '',
//               reasonForVisit: '',
//               status: true,
//             ))
//         .listen((appointments) {
//       WidgetsBinding.instance.addPostFrameCallback((_) {
//         if (appointments.isNotEmpty) {
//           isAppBooked = true;
//         } else {
//           isAppBooked = false;
//         }
//       });
//     }, onError: (error) {
//       WidgetsBinding.instance.addPostFrameCallback((_) {
//         debugPrint('Error fetching appointments: $error');
//         isAppBooked = false; // Handle error state if needed
//       });
//     });
//   }
// }

