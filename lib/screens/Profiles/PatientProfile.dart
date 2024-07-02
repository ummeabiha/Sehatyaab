import 'package:flutter/material.dart';
import 'package:sehatyaab/widgets/ElevatedButton.dart';
import '../../globals.dart';
import '../../models/Patient.dart';
import '../../routes/AppRoutes.dart';
import '../../services/FirestoreService.dart';
import '../../widgets/CustomAppBar.dart';
import '../../widgets/CustomContainer.dart';
import '../PatientDetails/ExpandableDetailTile.dart';
import '../PatientDetails/ProfileStackWidget.dart';

class PatientProfile extends StatelessWidget {
  const PatientProfile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Patient?>(
      future: _fetchPatient(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            appBar: const CustomAppBar(),
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            appBar: const CustomAppBar(),
            body: Center(
              child: Text('Error loading patient: ${snapshot.error}'),
            ),
          );
        } else if (!snapshot.hasData || snapshot.data == null) {
          return const Scaffold(
            appBar: const CustomAppBar(),
            body: Center(
              child: Text('Patient not found.'),
            ),
          );
        } else {
          Patient patient = snapshot.data!;
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
                  CustomElevatedButton(
                    onPressed: () => {
                      globalPatientId = '',
                      globalPatientEmail = '',
                      Navigator.pushReplacementNamed(context, AppRoutes.welcome)
                    },
                    label: "Sign Out",
                    removeUpperBorders: true,
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
                          title: 'Medical History',
                          type: patient.medicalHistoryType,
                          icon: 'assets/images/DoctorPanel/history.png',
                          year: patient.medicalHistoryYear?.toString(),
                          medicalHistory: patient.medicalHistoryDesc,
                        ),
                        const SizedBox(height: 16),
                        ExpandableDetailTile(
                          title: 'Family History',
                          type: patient.familyHistoryType,
                          icon: 'assets/images/DoctorPanel/family.png',
                          familyHistory: patient.familyHistoryDesc,
                        ),
                        const SizedBox(height: 16),
                        ExpandableDetailTile(
                          title: 'Medications',
                          type: 'Medicines',
                          icon: 'assets/images/DoctorPanel/meds.png',
                          onGoingMeds: patient.ongoingMedications,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }

  Future<Patient?> _fetchPatient() async {
    try {
      final FirestoreService<Patient> firestoreService =
          FirestoreService<Patient>('patients');
      return await firestoreService.getItemById(
          globalPatientId!,
          Patient(
            id: '',
            name: '',
            email: '',
            gender: '',
            dob: '',
            height: 0,
            weight: 0,
          ));
    } catch (e) {
      debugPrint('Error fetching patient: $e');
      return null;
    }
  }
}
