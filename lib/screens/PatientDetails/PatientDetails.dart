import 'package:flutter/material.dart';
import 'package:sehatyaab/models/Appointments.dart';
import 'package:sehatyaab/models/Patient.dart';
import '../../widgets/CustomAppBar.dart';
import '../../widgets/CustomContainer.dart';
import 'ExpandableDetailTile.dart';
import 'ProfileStackWidget.dart';

class PatientDetailsPage extends StatelessWidget {
  final Patient patient;
  final List<Appointment> appointments;

  const PatientDetailsPage({
    super.key,
    required this.patient,
    required this.appointments,
  });

  @override
  Widget build(BuildContext context) {

    List<Appointment> filteredAppointments = appointments
        .where((appointment) => patient.id.contains(appointment.patientId))
        .toList();
    debugPrint(filteredAppointments.toString());

    return Scaffold(
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ProfileStackWidget(
              name: patient.name,
              email: patient.email,
              gender: patient.gender,
            ),
            CustomContainer(
              child: Column(
                children: [
                  const SizedBox(height: 6),
                  ExpandableDetailTile(
                    title: 'Information',
                    icon: 'assets/images/DoctorPanel/info.png',
                    age: calculateAge(DateTime.parse(patient.dob)),
                    gender: patient.gender,
                  ),
                  const SizedBox(height: 16),
                  ExpandableDetailTile(
                    title: 'Anthropometrics',
                    icon: 'assets/images/DoctorPanel/BMI.png',
                    weight: '${patient.weight} kgs',
                    height: '${patient.height} inches',
                  ),
                  const SizedBox(height: 16),
                  ExpandableDetailTile(
                    title: 'Vitals',
                    icon: 'assets/images/DoctorPanel/vitals.png',
                    vitals: true,
                    hasBP: patient.isBpPatient,
                    hasSugar: patient.isSugarPatient,
                  ),
                  const SizedBox(height: 16),
                  ExpandableDetailTile(
                    title: 'Appointment',
                    icon: 'assets/images/DoctorPanel/details.png',
                    reasonForVisit: filteredAppointments[0].reasonForVisit,
                  ),
                  const SizedBox(height: 16),
                  if (patient.medicalHistoryType != null)
                    ExpandableDetailTile(
                      title: 'Medical History',
                      type: patient.medicalHistoryType!,
                      icon: 'assets/images/DoctorPanel/history.png',
                      year: patient.medicalHistoryYear.toString(),
                      medicalHistory: patient.medicalHistoryDesc!,
                    ),
                  const SizedBox(height: 16),
                  if (patient.familyHistoryType != null)
                    ExpandableDetailTile(
                      title: 'Family History',
                      type: patient.familyHistoryType!,
                      icon: 'assets/images/DoctorPanel/family.png',
                      familyHistory:
                          patient.familyHistoryDesc ?? 'No Description',
                    ),
                  const SizedBox(height: 16),
                  if (patient.ongoingMedications != null)
                    ExpandableDetailTile(
                      title: 'Medications',
                      type: 'Medicines',
                      icon: 'assets/images/DoctorPanel/meds.png',
                      onGoingMeds: patient.ongoingMedications!,
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
