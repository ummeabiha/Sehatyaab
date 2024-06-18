import 'package:flutter/material.dart';
import 'package:sehatyaab/models/Appointments.dart';
import 'package:sehatyaab/models/Patient.dart';
import 'package:sehatyaab/widgets/CustomAppBar.dart';
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
  late Future<List<Patient>> _patientsFuture;

  @override
  void initState() {
    super.initState();
    _patientsFuture = _loadPatients();
  }

  Future<List<Patient>> _loadPatients() async {
    final appointments = await widget.appointmentService
        .getItemsStream(Appointment(
          id: '',
          date: '',
          time: '',
          patientId: '',
          reasonForVisit: '',
          doctorId: widget.doctorId,
        ))
        .first;

    List<String> patientIds =
        appointments.map((appointment) => appointment.patientId).toList();

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(), // Assuming CustomAppBar is correctly implemented
      body: FutureBuilder<List<Patient>>(
        future: _patientsFuture,
        builder: (context, AsyncSnapshot<List<Patient>> patientSnapshot) {
          if (patientSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (patientSnapshot.hasError) {
            return Center(child: Text('Error fetching patients'));
          } else if (!patientSnapshot.hasData ||
              patientSnapshot.data!.isEmpty) {
            return Center(child: Text('No patients found'));
          } else {
            final patients = patientSnapshot.data!;

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
                  title: Text(patient.name),
                  subtitle: Text(patient.email),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          // Implement eye icon functionality (view details)
                        },
                        icon: Icon(Icons.remove_red_eye),
                      ),
                      IconButton(
                        onPressed: () {
                          // Implement video call icon functionality
                        },
                        icon: Icon(Icons.video_camera_front_rounded),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
