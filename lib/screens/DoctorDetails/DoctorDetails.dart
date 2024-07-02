import 'package:flutter/material.dart';
import '../../globals.dart';
import '../../models/Doctor.dart';
import '../../widgets/CustomAppBar.dart';
import '../../widgets/CustomContainer.dart';
import '../PatientDetails/ExpandableDetailTile.dart';
import '../PatientDetails/ProfileStackWidget.dart';

class DoctorDetails extends StatelessWidget {
  final Doctor doctor;

  const DoctorDetails({
    super.key,
    required this.doctor,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ProfileStackWidget(
              name: doctor.name,
              email: doctor.email,
              gender: doctor.gender,
              isDoctor: true,
            ),
            CustomContainer(
              child: Column(
                children: [
                  const SizedBox(height: 6),
                  ExpandableDetailTile(
                    title: 'Information',
                    icon: 'assets/images/DoctorPanel/info.png',
                    age: calculateAge(DateTime.parse(doctor.dob!)),
                    gender: doctor.gender,
                  ),
                  const SizedBox(height: 16),
                  ExpandableDetailTile(
                    title: 'Specialization',
                    icon: 'assets/images/DoctorPanel/specialization.png',
                    specialization: doctor.specialization,
                    years: doctor.yearsOfExperience,
                  ),
                  const SizedBox(height: 16),
                  ExpandableDetailTile(
                    title: 'Qualifications',
                    type: 'Qualification',
                    icon: 'assets/images/DoctorPanel/qualification.png',
                    onGoingMeds: doctor.qualification,
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
