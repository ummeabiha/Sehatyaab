import 'package:flutter/material.dart';
import 'package:sehatyaab/models/Doctor.dart';
import 'package:sehatyaab/services/FirestoreService.dart';

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
      )),
      builder: (context, AsyncSnapshot<List<Doctor>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          print('Waiting for data...');
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          print('Error fetching data: ${snapshot.error}');
          return Center(child: Text('Error fetching data'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          print('No doctors found');
          return Center(child: Text('No doctors found'));
        } else {
          final doctors = snapshot.data!;
          print('Doctors fetched: ${doctors.length}');

          return ListView.builder(
            itemCount: doctors.length,
            itemBuilder: (BuildContext context, int index) {
              var doctor = doctors[index];
              print('Doctor: ${doctor.name}, ${doctor.email}, ${doctor.dob}');

              return ListTile(
                leading: const CircleAvatar(
                  radius: 25,
                  backgroundImage: AssetImage('assets/images/female.png'),
                ),
                title: Text(doctor.name),
                subtitle: Text(doctor.specialization),
                trailing: TextButton(
                  onPressed: () {
                    // Implement booking functionality
                  },
                  child: Text("Book Now"),
                ),
              );
            },
          );
        }
      },
    );
  }
}
