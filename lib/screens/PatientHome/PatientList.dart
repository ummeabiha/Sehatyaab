import 'package:flutter/material.dart';
import 'package:sehatyaab/models/Doctor.dart';
import 'package:sehatyaab/services/FirestoreService.dart';
import 'package:sehatyaab/routes/AppRoutes.dart';

class PatientList extends StatelessWidget {
  final FirestoreService<Doctor> firestoreService;

  const PatientList({super.key, required this.firestoreService});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Doctor>>(
      stream: firestoreService.getItemsStream(Doctor(
        id: '',
        name: '',
        email: '',
        gender: '',
        dob: '',
        specialization: '',
        qualification: '',
        yearsOfExperience: 0,
        availableSlots: [],
        bookedSlots: [],
      )),
      builder: (context, AsyncSnapshot<List<Doctor>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          debugPrint('Waiting for data...');
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          debugPrint('Error fetching data: ${snapshot.error}');
          return const Center(child: Text('Error fetching data'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          debugPrint('No doctors found');
          return const Center(child: Text('No doctors found'));
        } else {
          final doctors = snapshot.data!;
          debugPrint('Doctors fetched: ${doctors.length}');

          return ListView.builder(
            itemCount: doctors.length,
            itemBuilder: (BuildContext context, int index) {
              var doctor = doctors[index];
              debugPrint(
                  'Doctor: ${doctor.name}, ${doctor.email}, ${doctor.dob}');

              return ListTile(
                leading: const CircleAvatar(
                  radius: 25,
                  backgroundImage: AssetImage('assets/images/female.png'),
                ),
                title: Text(doctor.name),
                subtitle: Text(doctor.specialization),
                trailing: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.doctordesc);
                  },
                  child: const Text("Book Now"),
                ),
              );
            },
          );
        }
      },
    );
  }
}
