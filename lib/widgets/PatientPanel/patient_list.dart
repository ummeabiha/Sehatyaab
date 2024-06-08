import 'package:flutter/material.dart';
import '../../models/patient.dart';
import '../../services/firestore_service.dart';

class PatientList extends StatelessWidget {
  final FirestoreService<Patient> firestoreService;

  const PatientList({super.key, required this.firestoreService});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Patient>>(
      stream: firestoreService.getItemsStream(Patient(
        id: '',
        name: '',
        email: '',
        gender: '',
        dob: '',
        height: 0.0,
        weight: 0.0,
      )),
      builder: (context, AsyncSnapshot<List<Patient>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          print('Waiting for data...');
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          print('Error fetching data: ${snapshot.error}');
          return Center(child: Text('Error fetching data'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          print('No patients found');
          return Center(child: Text('No patients found'));
        } else {
          final patients = snapshot.data!;
          print('Patients fetched: ${patients.length}');

          return ListView.builder(
            itemCount: patients.length,
            itemBuilder: (BuildContext context, int index) {
              var patient = patients[index];
              print(
                  'Patient: ${patient.name}, ${patient.email}, ${patient.dob}');

              return ListTile(
                title: Text(patient.name),
                subtitle: Text(patient.email),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    firestoreService.deleteItem(patient.id);
                  },
                ),
              );
            },
          );
        }
      },
    );
  }
}
