import 'package:flutter/material.dart';
import '../../models/patient.dart';
import '../../services/firestore_service.dart';

class PatientList extends StatelessWidget {
  final List<Patient> patients;

  const PatientList({Key? key, required this.patients}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firestoreService = FirestoreService<Patient>('/patients');

    return ListView.builder(
      itemCount: patients.length,
      itemBuilder: (BuildContext context, int index) {
        var patient = patients[index];

        return ListTile(
          title: Text(patient.name),
          subtitle: Text(patient.email),
          trailing: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              firestoreService.deleteItem(patient.id!);
            },
          ),
        );
      },
    );
  }
}
