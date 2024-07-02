// import 'package:flutter/material.dart';
// import '../../models/Doctor.dart';
// import '../../widgets/CustomAppBar.dart';
// import '../../widgets/CustomContainer.dart';
// import '../PatientDetails/ProfileStackWidget.dart';


// class DoctorDetailsPage extends StatelessWidget {
//   final Doctor doctor;

//   const DoctorDetailsPage({
//     super.key,
//     required this.doctor,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: const CustomAppBar(),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             ProfileStackWidget(
//               name: doctor.name,
//               email: doctor.email,
//               gender: doctor.gender,
//             ),
//             CustomContainer(
//               child: Column(
//                 children: [
//                   const SizedBox(height: 6),
//                   ExpandableDetailTile(
//                     title: 'Information',
//                     icon: 'assets/images/DoctorPanel/info.png',
//                     age: calculateAge(DateTime.parse(patient.dob)),
//                     gender: patient.gender,
//                   ),
//                   const SizedBox(height: 16),
//                   ExpandableDetailTile(
//                     title: 'Anthropometrics',
//                     icon: 'assets/images/DoctorPanel/BMI.png',
//                     weight: '${patient.weight} kgs',
//                     height: '${patient.height} inches',
//                   ),
//                   const SizedBox(height: 16),
//                   ExpandableDetailTile(
//                     title: 'Vitals',
//                     icon: 'assets/images/DoctorPanel/vitals.png',
//                     vitals: true,
//                     hasBP: patient.isBpPatient,
//                     hasSugar: patient.isSugarPatient,
//                   ),
//                   const SizedBox(height: 16),
//                   if (filteredAppointments.isNotEmpty)
//                     ExpandableDetailTile(
//                       title: 'Appointment',
//                       icon: 'assets/images/DoctorPanel/details.png',
//                       reasonForVisit: filteredAppointments[0].reasonForVisit,
//                     ),
//                   const SizedBox(height: 16),
//                   ExpandableDetailTile(
//                     title: 'Medical History',
//                     type: patient.medicalHistoryType,
//                     icon: 'assets/images/DoctorPanel/history.png',
//                     year: patient.medicalHistoryYear?.toString(),
//                     medicalHistory: patient.medicalHistoryDesc,
//                   ),
//                   const SizedBox(height: 16),
//                   ExpandableDetailTile(
//                       title: 'Family History',
//                       type: patient.familyHistoryType,
//                       icon: 'assets/images/DoctorPanel/family.png',
//                       familyHistory: patient.familyHistoryDesc),
//                   const SizedBox(height: 16),
//                   ExpandableDetailTile(
//                     title: 'Medications',
//                     type: 'Medicines',
//                     icon: 'assets/images/DoctorPanel/meds.png',
//                     onGoingMeds: patient.ongoingMedications,
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// int calculateAge(DateTime? birthDate) {
//   if (birthDate == null) return 0;

//   DateTime today = DateTime.now();
//   int age = today.year - birthDate.year;
//   if (today.month < birthDate.month ||
//       (today.month == birthDate.month && today.day < birthDate.day)) {
//     age--;
//   }
//   return age;
// }
