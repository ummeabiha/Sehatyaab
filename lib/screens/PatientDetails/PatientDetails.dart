// import 'package:flutter/material.dart';
// import 'package:sehatyaab/models/Appointments.dart';
// import 'package:sehatyaab/models/Patient.dart';
// import 'package:sehatyaab/widgets/FormContainer.dart';
// import '../../widgets/CustomAppBar.dart';
// import '../../widgets/ExpandableDetailTile.dart';
// import '../../widgets/ListTileWithCheckbox.dart';

// class PatientDetailsPage extends StatelessWidget {
//   final Patient patient;
//   final List<Appointment> appointments;

//   const PatientDetailsPage(
//       {super.key, required this.patient, required this.appointments});

//   @override
//   Widget build(BuildContext context) {
//     String avatarImagePath = patient.gender == 'male'
//         ? 'assets/images/male.png'
//         : 'assets/images/female.png';

//     bool hasBP = patient.isBpPatient;
//     bool hasSugar = patient.isSugarPatient;

//     List<Appointment> filteredAppointments = appointments
//         .where((appointment) => (patient.id).contains(appointment.patientId))
//         .toList();
//     debugPrint(filteredAppointments as String?);

//     return Scaffold(
//         appBar: const CustomAppBar(),
//         body: SingleChildScrollView(
//             child: Column(children: [
//           Stack(
//             alignment: Alignment.center,
//             children: [
//               Container(
//                 height: MediaQuery.of(context).size.height * 0.32,
//                 decoration: BoxDecoration(
//                   color: Theme.of(context).primaryColor,
//                   borderRadius: BorderRadius.circular(12.0),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.1),
//                       spreadRadius: 2,
//                       blurRadius: 4,
//                       offset: const Offset(0, 2),
//                     ),
//                   ],
//                 ),
//                 width: double.infinity,
//                 padding: const EdgeInsets.symmetric(vertical: 12.0),
//               ),
//               Positioned(
//                 top: 40.0,
//                 child: Column(
//                   children: [
//                     Container(
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         border: Border.all(
//                           color: Theme.of(context).cardColor,
//                           width: 2.0,
//                         ),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withOpacity(0.1),
//                             spreadRadius: 2,
//                             blurRadius: 4,
//                             offset: Offset(0, 2),
//                           ),
//                         ],
//                       ),
//                       child: CircleAvatar(
//                         radius: 50,
//                         backgroundImage: AssetImage(avatarImagePath),
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 16,
//                     ),
//                     Container(
//                       child: Text(
//                         patient.name,
//                         style: Theme.of(context).textTheme.bodyLarge,
//                       ),
//                     ),
//                     Text(
//                       patient.email,
//                       style: Theme.of(context)
//                           .textTheme
//                           .bodyMedium
//                           ?.copyWith(fontWeight: FontWeight.w500),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           //SizedBox(height: 34),
//           Container(
//             decoration: BoxDecoration(
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.1),
//                   spreadRadius: 2,
//                   blurRadius: 4,
//                   offset: Offset(0, 2),
//                 ),
//               ],
//               color: Theme.of(context).cardColor,
//             ),
//             padding: EdgeInsets.all(20),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 Column(
//                   children: [
//                     Text(
//                       '${calculateAge(DateTime.parse(patient.dob))}',
//                       style: Theme.of(context)
//                           .textTheme
//                           .bodyMedium
//                           ?.copyWith(color: Theme.of(context).primaryColor),
//                     ),
//                     SizedBox(height: 4),
//                     Text(
//                       'Age',
//                       style: Theme.of(context)
//                           .textTheme
//                           .bodySmall
//                           ?.copyWith(color: Theme.of(context).primaryColor),
//                     ),
//                   ],
//                 ),
//                 Column(
//                   children: [
//                     Text(
//                       '${patient.weight}',
//                       style: Theme.of(context)
//                           .textTheme
//                           .bodyMedium
//                           ?.copyWith(color: Theme.of(context).primaryColor),
//                     ),
//                     SizedBox(height: 4),
//                     Text(
//                       'Weight',
//                       style: Theme.of(context)
//                           .textTheme
//                           .bodySmall
//                           ?.copyWith(color: Theme.of(context).primaryColor),
//                     ),
//                   ],
//                 ),
//                 Column(
//                   children: [
//                     Text(
//                       '${patient.height}',
//                       style: Theme.of(context)
//                           .textTheme
//                           .bodyMedium
//                           ?.copyWith(color: Theme.of(context).primaryColor),
//                     ),
//                     SizedBox(height: 4),
//                     Text(
//                       'Height',
//                       style: Theme.of(context).textTheme.bodySmall?.copyWith(
//                           color: const Color.fromARGB(204, 216, 215, 215)),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),

//           FormContainer(
//               child: Column(
//             children: [
//               //SizedBox(height: 34),
//               ListTileWithCheckbox(
//                 title: 'Blood Pressure',
//                 value: hasBP,
//               ),
//               SizedBox(height: 12),
//               ListTileWithCheckbox(
//                 title: 'Sugar',
//                 value: hasSugar,
//               ),
//               SizedBox(height: 12),
//               //  ExpandableDetailTile(
//               //   title: 'Appointment Details',
//               //   type: appointment.reasonForVisit!,
//               //   description: patient.medicalHistoryDesc ?? 'No Description',
//               // ),

//               SizedBox(height: 12),
//               if (patient.medicalHistoryType != null)
//                 ExpandableDetailTile(
//                   title: 'Medical History',
//                   type: patient.medicalHistoryType!,
//                   description: patient.medicalHistoryDesc ?? 'No Description',
//                 ),
//               SizedBox(height: 12),
//               if (patient.familyHistoryType != null)
//                 ExpandableDetailTile(
//                   title: 'Family History',
//                   type: patient.familyHistoryType!,
//                   description: patient.familyHistoryDesc ?? 'No Description',
//                 ),
//               SizedBox(height: 12),
//               if (patient.ongoingMedications != null)
//                 ExpandableDetailTile(
//                   title: 'Ongoing Medications',
//                   type: 'Medicines',
//                   description: patient.ongoingMedications!,
//                 ),
//             ],
//           ))
//         ])));
//   }
// }

// //         body: Container(
// //           child: FormContainer(
// //             child: SingleChildScrollView(
// //               child: Column(
// //                 mainAxisSize: MainAxisSize.min,
// //                 children: [
// //                   CircleAvatar(
// //                     radius: 50,
// //                     backgroundImage: AssetImage(avatarImagePath),
// //                   ),
// //                   const SizedBox(height: 22),
// //                   Text(
// //                     patient.name,
// //                     style: Theme.of(context).textTheme.bodyLarge,
// //                   ),
// //                   SizedBox(height: 2),
// //                   Text(
// //                     patient.email,
// //                     style: Theme.of(context)
// //                         .textTheme
// //                         .bodyMedium
// //                         ?.copyWith(fontWeight: FontWeight.w500),
// //                   ),
// //                   SizedBox(height: 34),
// //                   Container(
// //                     child: Row(
// //                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// //                       children: [
// //                         Column(
// //                           children: [
// //                             Text(
// //                               '${calculateAge(DateTime.parse(patient.dob))}',
// //                               style: Theme.of(context).textTheme.bodyMedium,
// //                             ),
// //                             SizedBox(height: 4),
// //                             Text(
// //                               'Age',
// //                               style: Theme.of(context)
// //                                   .textTheme
// //                                   .bodySmall
// //                                   ?.copyWith(
// //                                       color: Theme.of(context).cardColor),
// //                             ),
// //                           ],
// //                         ),
// //                         Column(
// //                           children: [
// //                             Text(
// //                               '${patient.weight}',
// //                               style: Theme.of(context).textTheme.bodyMedium,
// //                             ),
// //                             SizedBox(height: 4),
// //                             Text(
// //                               'Weight',
// //                               style: Theme.of(context).textTheme.bodySmall,
// //                             ),
// //                           ],
// //                         ),
// //                         Column(
// //                           children: [
// //                             Text(
// //                               '${patient.height}',
// //                               style: Theme.of(context).textTheme.bodyMedium,
// //                             ),
// //                             SizedBox(height: 4),
// //                             Text(
// //                               'Height',
// //                               style: Theme.of(context).textTheme.bodySmall,
// //                             ),
// //                           ],
// //                         ),
// //                       ],
// //                     ),
// //                   ),
// //                   SizedBox(height: 34),
// //                   ListTileWithCheckbox(
// //                     title: 'Blood Pressure',
// //                     value: hasBP,
// //                   ),
// //                   SizedBox(height: 12),
// //                   ListTileWithCheckbox(
// //                     title: 'Sugar',
// //                     value: hasSugar,
// //                   ),
// //                   SizedBox(height: 12),
// //                   if (patient.medicalHistoryType != null)
// //                     ExpandableDetailTile(
// //                       title: 'Medical History',
// //                       type: patient.medicalHistoryType!,
// //                       year: patient.medicalHistoryYear,
// //                       description:
// //                           patient.medicalHistoryDesc ?? 'No Description',
// //                     ),
// //                   SizedBox(height: 12),
// //                   if (patient.familyHistoryType != null)
// //                     ExpandableDetailTile(
// //                       title: 'Family History',
// //                       type: patient.familyHistoryType!,
// //                       description:
// //                           patient.familyHistoryDesc ?? 'No Description',
// //                     ),
// //                   SizedBox(height: 12),
// //                   if (patient.ongoingMedications != null)
// //                     ExpandableDetailTile(
// //                       title: 'Ongoing Medications',
// //                       type: 'Medicines',
// //                       description: patient.ongoingMedications!,
// //                     ),
// //                 ],
// //               ),
// //             ),
// //           ),
// //         ));
// //   }
// // }

// int calculateAge(DateTime birthDate) {
//   DateTime today = DateTime.now();
//   int age = today.year - birthDate.year;
//   if (today.month < birthDate.month ||
//       (today.month == birthDate.month && today.day < birthDate.day)) {
//     age--;
//   }
//   return age;
// }

import 'package:flutter/material.dart';
import 'package:sehatyaab/models/Appointments.dart';
import 'package:sehatyaab/models/Patient.dart';
import 'package:sehatyaab/widgets/FormContainer.dart';
import '../../widgets/CustomAppBar.dart';
import '../../widgets/CustomContainer.dart';
import 'ExpandableDetailTile.dart';
import 'ListTileWithCheckbox.dart';

class PatientDetailsPage extends StatelessWidget {
  final Patient patient;
  final List<Appointment> appointments;

  const PatientDetailsPage(
      {super.key, required this.patient, required this.appointments});

  @override
  Widget build(BuildContext context) {
    String avatarImagePath = patient.gender == 'male'
        ? 'assets/images/male.png'
        : 'assets/images/female.png';

    bool hasBP = patient.isBpPatient;
    bool hasSugar = patient.isSugarPatient;

    List<Appointment> filteredAppointments = appointments
        .where((appointment) => patient.id.contains(appointment.patientId))
        .toList();
    debugPrint(filteredAppointments.toString());

    return Scaffold(
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.32,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(12.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 2,
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                ),
                Positioned(
                  top: 40.0,
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Theme.of(context).cardColor,
                            width: 2.0,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              spreadRadius: 2,
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage: AssetImage(avatarImagePath),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        patient.name,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      Text(
                        patient.email,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
                color: Theme.of(context).cardColor,
              ),
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text(
                        '${calculateAge(DateTime.parse(patient.dob))}',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: Theme.of(context).primaryColor),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Age',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: Theme.of(context).primaryColor),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        '${patient.weight}',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: Theme.of(context).primaryColor),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Weight',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: Theme.of(context).primaryColor),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        '${patient.height}',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: Theme.of(context).primaryColor),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Height',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: const Color.fromARGB(204, 216, 215, 215)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            CustomContainer(
              child: Column(
                children: [
                  // ListTileWithCheckbox(
                  //   title: 'Blood Pressure',
                  //   value: hasBP,
                  // ),
                  // const SizedBox(height: 12),
                  // ListTileWithCheckbox(
                  //   title: 'Sugar',
                  //   value: hasSugar,
                  // ),
                  const SizedBox(height: 14),
                  ExpandableDetailTile(
                    title: 'Anthropometric',
                    icon: 'assets/images/BMI.png',
                    weight: patient.weight,
                    height: patient.height,
                  ),
                  const SizedBox(height: 14),
                  ExpandableDetailTile(
                    title: 'Appointment',
                    icon: 'assets/images/details.png',
                    reasonForVisit: filteredAppointments[0].reasonForVisit,
                  ),
                  const SizedBox(height: 14),
                  if (patient.medicalHistoryType != null)
                    ExpandableDetailTile(
                      title: 'Medical History',
                      type: patient.medicalHistoryType!,
                      icon: 'assets/images/history.png',
                      year: patient.medicalHistoryYear.toString(),
                      description: patient.medicalHistoryDesc!,
                    ),
                  const SizedBox(height: 14),
                  if (patient.familyHistoryType != null)
                    ExpandableDetailTile(
                      title: 'Family History',
                      type: patient.familyHistoryType!,
                      icon: 'assets/images/history.png',
                      description:
                          patient.familyHistoryDesc ?? 'No Description',
                    ),
                  const SizedBox(height: 14),
                  if (patient.ongoingMedications != null)
                    ExpandableDetailTile(
                      title: 'Medications',
                      type: 'Medicines',
                      icon: 'assets/images/meds.png',
                      description: patient.ongoingMedications!,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

int calculateAge(DateTime birthDate) {
  DateTime today = DateTime.now();
  int age = today.year - birthDate.year;
  if (today.month < birthDate.month ||
      (today.month == birthDate.month && today.day < birthDate.day)) {
    age--;
  }
  return age;
}
