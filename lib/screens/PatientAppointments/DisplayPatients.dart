// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:rxdart/rxdart.dart';
// import 'package:sehatyaab/models/Patient.dart';
// import 'package:sehatyaab/screens/PatientDetails/PatientDetails.dart';
// import 'package:sehatyaab/widgets/CustomContainer.dart';
// import '../../models/Appointments.dart';
// import '../../services/FirestoreService.dart';

// class DisplayPatients extends StatefulWidget {
//   final FirestoreService<Appointment> appointmentService;
//   final FirestoreService<Patient> patientService;
//   final String doctorId;

//   const DisplayPatients({
//     Key? key,
//     required this.appointmentService,
//     required this.patientService,
//     required this.doctorId,
//   }) : super(key: key);

//   @override
//   _DisplayPatientsState createState() => _DisplayPatientsState();
// }

// class _DisplayPatientsState extends State<DisplayPatients>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//   late BehaviorSubject<List<Patient>> _allPatientsSubject;
//   late BehaviorSubject<List<Patient>> _todayPatientsSubject;
//   late BehaviorSubject<List<Patient>> _tomorrowPatientsSubject;
//   List<Appointment> appointments = [];
//   List<Patient> allPatients = [];
//   List<Patient> todayPatients = [];
//   List<Patient> tomorrowPatients = [];

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 3, vsync: this);
//     _tabController.addListener(_handleTabSelection);
//     _initializeStreams();
//     _listenToAppointments();
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     _allPatientsSubject.close();
//     _todayPatientsSubject.close();
//     _tomorrowPatientsSubject.close();
//     super.dispose();
//   }

//   void _initializeStreams() {
//     _allPatientsSubject = BehaviorSubject<List<Patient>>();
//     _todayPatientsSubject = BehaviorSubject<List<Patient>>();
//     _tomorrowPatientsSubject = BehaviorSubject<List<Patient>>();
//   }

//   void _listenToAppointments() {
//     widget.appointmentService
//         .getItemsByDoctorIdStream(
//       widget.doctorId,
//       Appointment(
//         id: '',
//         date: '',
//         time: '',
//         patientId: '',
//         doctorId: '',
//         reasonForVisit: '',
//       ),
//     )
//         .listen((appointments) async {
//       this.appointments = appointments;
//       this.appointments.sort((a, b) => a.time.compareTo(b.time));

//       List<String> patientIds =
//           appointments.map((appointment) => appointment.patientId).toList();

//       allPatients = [];
//       todayPatients = [];
//       tomorrowPatients = [];

//       var today = DateTime.now().toLocal().toString().split(' ')[0];
//       var tomorrow = DateTime.now()
//           .add(Duration(days: 1))
//           .toLocal()
//           .toString()
//           .split(' ')[0];

//       for (int i = 0; i < patientIds.length; i++) {
//         String patientId = patientIds[i];
//         Patient patient = await widget.patientService.getItemById(
//           patientId,
//           Patient(
//             id: '',
//             name: '',
//             email: '',
//             gender: '',
//             dob: '',
//             height: 0.0,
//             weight: 0.0,
//           ),
//         );
//         allPatients.add(patient);

//         Appointment appointment = appointments[i];

//         var appDate = appointment.date;
//         if (appDate == today) {
//           todayPatients.add(patient);
//         } else if (appDate == tomorrow) {
//           tomorrowPatients.add(patient);
//         }
//       }

//       _allPatientsSubject.add(allPatients);
//       _todayPatientsSubject.add(todayPatients);
//       _tomorrowPatientsSubject.add(tomorrowPatients);
//     });
//   }

//   void _handleTabSelection() {
//     if (_tabController.indexIsChanging) {
//       setState(() {});
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Appointments'),
//         bottom: TabBar(
//           controller: _tabController,
//           tabs: [
//             Tab(text: 'All'),
//             Tab(text: 'Today'),
//             Tab(text: 'Tomorrow'),
//           ],
//         ),
//       ),
//       body: TabBarView(
//         controller: _tabController,
//         children: [
//           _buildAppointmentsList(_allPatientsSubject.stream),
//           _buildAppointmentsList(_todayPatientsSubject.stream),
//           _buildAppointmentsList(_tomorrowPatientsSubject.stream),
//         ],
//       ),
//     );
//   }

//   Widget _buildAppointmentsList(Stream<List<Patient>> patientsStream) {
//     return CustomContainer(
//       child: StreamBuilder<List<Patient>>(
//         stream: patientsStream,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           }

//           final List<Patient>? patientsList = snapshot.data;
//           if (patientsList == null || patientsList.isEmpty) {
//             return const Center(child: Text('No appointments found.'));
//           }

//           return ListView.builder(
//             itemCount: patientsList.length,
//             itemBuilder: (BuildContext context, int index) {
//               var patient = patientsList[index];
//               String avatarImagePath = patient.gender == 'male'
//                   ? 'assets/images/male.png'
//                   : 'assets/images/female.png';

//               return ListTile(
//                 leading: CircleAvatar(
//                   radius: 25,
//                   backgroundImage: AssetImage(avatarImagePath),
//                 ),
//                 title: Text(patient.name.isNotEmpty ? patient.name : 'Unknown',
//                     style: Theme.of(context).textTheme.bodyMedium),
//                 subtitle: Text(patient.dob.isNotEmpty ? patient.dob : 'Unknown',
//                     style: Theme.of(context).textTheme.bodySmall),
//                 trailing: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     IconButton(
//                       onPressed: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => PatientDetailsPage(
//                                 patient: patient,
//                                 appointments: this.appointments),
//                           ),
//                         );
//                       },
//                       icon: Icon(Icons.remove_red_eye,
//                           size: 32.0, color: Theme.of(context).cardColor),
//                     ),
//                     const SizedBox(width: 8.0),
//                     IconButton(
//                       onPressed: () {
//                         // Implement video call icon functionality
//                       },
//                       icon: Icon(Icons.video_camera_front_rounded,
//                           size: 32.0, color: Theme.of(context).cardColor),
//                     ),
//                   ],
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sehatyaab/models/Patient.dart';
import 'package:sehatyaab/screens/PatientDetails/PatientDetails.dart';
import 'package:sehatyaab/widgets/CustomAppBar.dart';
import 'package:sehatyaab/widgets/CustomContainer.dart';
import '../../models/Appointments.dart';
import '../../services/FirestoreService.dart';
import '../../widgets/FormContainer.dart';

class DisplayPatients extends StatefulWidget {
  final FirestoreService<Appointment> appointmentService;
  final FirestoreService<Patient> patientService;
  final String doctorId;

  const DisplayPatients({
    super.key,
    required this.appointmentService,
    required this.patientService,
    required this.doctorId,
  });

  @override
  _DisplayPatientsState createState() => _DisplayPatientsState();
}

class _DisplayPatientsState extends State<DisplayPatients>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late BehaviorSubject<List<Patient>> _allPatientsSubject;
  late BehaviorSubject<List<Patient>> _todayPatientsSubject;
  late BehaviorSubject<List<Patient>> _tomorrowPatientsSubject;
  List<Appointment> appointments = [];
  List<Patient> allPatients = [];
  List<Patient> todayPatients = [];
  List<Patient> tomorrowPatients = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_handleTabSelection);
    _initializeStreams();
    _listenToAppointments();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _allPatientsSubject.close();
    _todayPatientsSubject.close();
    _tomorrowPatientsSubject.close();
    super.dispose();
  }

  void _initializeStreams() {
    _allPatientsSubject = BehaviorSubject<List<Patient>>();
    _todayPatientsSubject = BehaviorSubject<List<Patient>>();
    _tomorrowPatientsSubject = BehaviorSubject<List<Patient>>();
  }

  void _listenToAppointments() {
    widget.appointmentService
        .getItemsByDoctorIdStream(
      widget.doctorId,
      Appointment(
        id: '',
        date: '',
        time: '',
        patientId: '',
        doctorId: '',
        reasonForVisit: '',
      ),
    )
        .listen((appointments) async {
      this.appointments = appointments;
      this.appointments.sort((a, b) => a.time.compareTo(b.time));

      List<String> patientIds =
          appointments.map((appointment) => appointment.patientId).toList();

      allPatients = [];
      todayPatients = [];
      tomorrowPatients = [];

      var today = DateTime.now().toLocal().toString().split(' ')[0];
      var tomorrow = DateTime.now()
          .add(const Duration(days: 1))
          .toLocal()
          .toString()
          .split(' ')[0];

      for (int i = 0; i < patientIds.length; i++) {
        String patientId = patientIds[i];
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
          ),
        );
        allPatients.add(patient);

        Appointment appointment = appointments[i];

        var appDate = appointment.date;
        if (appDate == today) {
          todayPatients.add(patient);
        } else if (appDate == tomorrow) {
          tomorrowPatients.add(patient);
        }
      }

      _allPatientsSubject.add(allPatients);
      _todayPatientsSubject.add(todayPatients);
      _tomorrowPatientsSubject.add(tomorrowPatients);
    });
  }

  void _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: const CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  Text(
                    'Appointment Details',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontWeight: FontWeight.w500, fontSize: 26.0),
                  ),
                  const SizedBox(width: 35.0),
                ],
              ),
            ),
            //const SizedBox(height: 12.0),
            //const Divider(),
            TabBar(
              controller: _tabController,
              tabs: [
                Tab(
                    child: Text(
                  'All',
                  style: Theme.of(context).textTheme.bodySmall,
                )),
                Tab(
                    child: Text(
                  'Today',
                  style: Theme.of(context).textTheme.bodySmall,
                )),
                Tab(
                    child: Text(
                  'Tmr',
                  style: Theme.of(context).textTheme.bodySmall,
                )),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildAppointmentsList(_allPatientsSubject.stream),
                  _buildAppointmentsList(_todayPatientsSubject.stream),
                  _buildAppointmentsList(_tomorrowPatientsSubject.stream),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppointmentsList(Stream<List<Patient>> patientsStream) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: const EdgeInsets.all(30.0),
      child: StreamBuilder<List<Patient>>(
        stream: patientsStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final List<Patient>? patientsList = snapshot.data;
          if (patientsList == null || patientsList.isEmpty) {
            return const Center(child: Text('No appointments found.'));
          }

          return ListView.builder(
            itemCount: patientsList.length,
            itemBuilder: (BuildContext context, int index) {
              var patient = patientsList[index];
              String avatarImagePath = patient.gender == 'male'
                  ? 'assets/images/male.png'
                  : 'assets/images/female.png';

              // Get the corresponding appointment time for the patient
              String appointmentTime = appointments
                  .firstWhere(
                    (appointment) => appointment.patientId == patient.id,
                  )
                  .time;

              return ListTile(
                leading: CircleAvatar(
                  radius: 25,
                  backgroundImage: AssetImage(avatarImagePath),
                ),
                title: Text(patient.name.isNotEmpty ? patient.name : 'Unknown',
                    style: Theme.of(context).textTheme.bodyMedium),
                subtitle: Text(appointmentTime,
                    style: Theme.of(context).textTheme.bodySmall),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PatientDetailsPage(
                                patient: patient,
                                appointments: this.appointments),
                          ),
                        );
                      },
                      icon: Icon(Icons.remove_red_eye,
                          size: 32.0, color: Theme.of(context).cardColor),
                    ),
                    const SizedBox(width: 8.0),
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
    );
  }
}
