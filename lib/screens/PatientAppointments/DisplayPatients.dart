import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sehatyaab/models/Appointments.dart';
import 'package:sehatyaab/models/Patient.dart';
import 'package:sehatyaab/screens/PatientDetails/PatientDetails.dart';
import 'package:sehatyaab/widgets/CustomAppBar.dart';
import 'package:sehatyaab/widgets/CustomContainer.dart';
import '../../services/FirestoreService.dart';

class DisplayPatients extends StatefulWidget {
  final FirestoreService<Appointment> appointmentService;
  final FirestoreService<Patient> patientService;
  final String doctorId;

  const DisplayPatients({
    Key? key,
    required this.appointmentService,
    required this.patientService,
    required this.doctorId,
  }) : super(key: key);

  @override
  _DisplayPatientsState createState() => _DisplayPatientsState();
}

class _DisplayPatientsState extends State<DisplayPatients> {
  late Stream<List<Patient>> _patientsStream;

  @override
  void initState() {
    super.initState();
    _listenToAppointments();
  }

  void _listenToAppointments() {
    _patientsStream = widget.appointmentService
        .getItemsStream(Appointment(
      id: '',
      date: '',
      time: '',
      patientId: '',
      reasonForVisit: '',
      doctorId: widget.doctorId,
    ))
        .asyncMap((appointments) async {
      List<String> patientIds =
          appointments.map((appointment) => appointment.patientId).toList();

      debugPrint('Patient IDs: $patientIds');

      List<Patient> patients = [];
      for (String patientId in patientIds) {
        Patient patient = await widget.patientService.getItemById(
            patientId,
            Patient(
              id: '',
              name: '',
              email: '',
              gender: '',
              dob: '',
              height: 0.0,
              weight: 0.0,
            ));
        patients.add(patient);
      }

      return patients;
    });

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: CustomContainer(
        child: StreamBuilder<List<Patient>>(
          stream: _patientsStream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            List<Patient> patients = snapshot.data ?? [];

            return ListView.builder(
              itemCount: patients.length,
              itemBuilder: (BuildContext context, int index) {
                var patient = patients[index];
                String avatarImagePath = patient.gender == 'male'
                    ? 'assets/images/male.png'
                    : 'assets/images/female.png';

                return ListTile(
                  leading: CircleAvatar(
                    radius: 25,
                    backgroundImage: AssetImage(avatarImagePath),
                  ),
                  title: Text(patient.name,
                      style: Theme.of(context).textTheme.bodyMedium),
                  subtitle: Text(patient.dob,
                      style: Theme.of(context).textTheme.bodySmall),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  PatientDetailsPage(patient: patient),
                            ),
                          );
                        },
                        icon: Icon(Icons.remove_red_eye,
                            size: 32.0, color: Theme.of(context).cardColor),
                      ),
                      SizedBox(width: 8.0),
                      IconButton(
                        onPressed: () {
                          // Implement video call icon functionality
                        },
                        icon: Icon(Icons.video_camera_front_rounded,
                            size: 32.0, color: Theme.of(context).cardColor),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
