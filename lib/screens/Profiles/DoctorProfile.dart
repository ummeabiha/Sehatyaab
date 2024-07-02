import 'package:flutter/material.dart';
import '../../globals.dart';
import '../../models/Doctor.dart';
import '../../routes/AppRoutes.dart';
import '../../services/FirestoreService.dart';
import '../../widgets/CustomAppBar.dart';
import '../../widgets/CustomContainer.dart';
import '../../widgets/ElevatedButton.dart';
import '../PatientDetails/ExpandableDetailTile.dart';
import '../PatientDetails/ProfileStackWidget.dart';

class DoctorProfile extends StatelessWidget {
  const DoctorProfile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Doctor?>(
      future: _fetchDoctor(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            appBar: CustomAppBar(),
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            appBar: const CustomAppBar(),
            body: Center(
              child: Text('Error loading doctor: ${snapshot.error}'),
            ),
          );
        } else if (!snapshot.hasData || snapshot.data == null) {
          return const Scaffold(
            appBar: CustomAppBar(),
            body: Center(
              child: Text('Doctor not found.'),
            ),
          );
        } else {
          Doctor doctor = snapshot.data!;
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
                  CustomElevatedButton(
                    onPressed: () => {
                      globalDoctorId = '',
                      globalDoctorEmail = '',
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
                          icon: 'assets/images/DoctorPanel/qualification.png',
                          type: 'Qualification',
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
      },
    );
  }

  Future<Doctor?> _fetchDoctor() async {
    try {
      final FirestoreService<Doctor> firestoreService =
          FirestoreService<Doctor>('doctors');
      return await firestoreService.getItemById(
        globalDoctorId!,
        Doctor(
          id: '',
          name: '',
          email: '',
          gender: '',
          dob: '',
          specialization: '',
          qualification: '',
          yearsOfExperience: 0,
        ),
      );
    } catch (e) {
      debugPrint('Error fetching doctor: $e');
      return null;
    }
  }
}
