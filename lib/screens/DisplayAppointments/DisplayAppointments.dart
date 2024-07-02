import 'dart:async';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sehatyaab/globals.dart';
import '../../models/Patient.dart';
import '../PatientDetails/PatientDetails.dart';
import '../VideoCall/VideoCall.dart';
import '../../widgets/CustomAppBar.dart';
import '../../models/Appointments.dart';
import '../../services/FirestoreService.dart';
import '../../theme/AppColors.dart';
import 'DoctorPanelHeader.dart';

class DisplayAppointments extends StatefulWidget {
  final FirestoreService<Appointment> appointmentService;
  final FirestoreService<Patient> patientService;
  final String doctorId;

  const DisplayAppointments({
    super.key,
    required this.appointmentService,
    required this.patientService,
    required this.doctorId,
  });

  @override
  _DisplayAppointmentsState createState() => _DisplayAppointmentsState();
}

class _DisplayAppointmentsState extends State<DisplayAppointments>
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
        status: true,
      ),
    )
        .listen((appointments) async {
      this.appointments = appointments;
      this.appointments.sort((a, b) => a.time.compareTo(b.time));

      //Filter patientIds based on appointment status
      List<String> patientIds = appointments
          .where((appointment) => appointment.status == true)
          .map((appointment) => appointment.patientId)
          .toList();

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
      appBar: const CustomAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const DoctorPanelHeader(
              imagePath: 'assets/images/DoctorPanel/appointment.png',
              text: 'Appointments'),
          Container(
            color: Theme.of(context).cardColor,
            padding: const EdgeInsets.only(top: 10.0),
            child: TabBar(
              dividerColor: Theme.of(context).primaryColor,
              indicatorColor: Theme.of(context).hoverColor,
              controller: _tabController,
              tabs: [
                Tab(
                  child: Text(
                    'All',
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: Theme.of(context).primaryColor),
                  ),
                ),
                Tab(
                  child: Text(
                    'Today',
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: Theme.of(context).primaryColor),
                  ),
                ),
                Tab(
                  child: Text(
                    'Later',
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: Theme.of(context).primaryColor),
                  ),
                ),
              ],
            ),
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
    );
  }

  Widget _buildAppointmentsList(Stream<List<Patient>> patientsStream) {
    return StreamBuilder<List<Patient>>(
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
            String avatarImagePath =
                patient.gender == 'male' || patient.gender == 'Male'
                    ? 'assets/images/DoctorPanel/boy.png'
                    : 'assets/images/DoctorPanel/girl.png';

            // Get the corresponding appointment time for the patient
            String appointmentTime = appointments
                .firstWhere(
                  (appointment) => appointment.patientId == patient.id,
                )
                .time;

            Color tileColor;
            if (Theme.of(context).brightness == Brightness.dark) {
              tileColor = index % 2 == 0 ? AppColors.gray1 : Colors.transparent;
            } else {
              tileColor = index % 2 == 0
                  ? Theme.of(context).primaryColor
                  : Colors.white;
            }

            return Material(
              elevation: 4.0,
              color: tileColor,
              shadowColor: Colors.black45,
              borderRadius: BorderRadius.circular(8.0),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 25,
                    backgroundColor: AppColors.blue2,
                    backgroundImage: AssetImage(avatarImagePath),
                  ),
                  title: Text(
                    patient.name.isNotEmpty ? patient.name : 'Unknown',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  subtitle: Text(
                    appointmentTime,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PatientDetailsPage(
                                  patient: patient, appointments: appointments),
                            ),
                          );
                        },
                        icon: Icon(
                          Icons.remove_red_eye,
                          size: 32.0,
                          color: Theme.of(context).cardColor,
                        ),
                      ),
                      const SizedBox(width: 20.0),
                      IconButton(
                        onPressed: () {
                          List<Appointment> filteredAppointments = appointments
                              .where((appointment) =>
                                  patient.id.contains(appointment.patientId))
                              .toList();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => VideoCall(
                                  userID: globalDoctorId!,
                                  userName: globalDoctorEmail!,
                                  appointmentID: filteredAppointments[0].id),
                            ),
                          );
                        },
                        icon: Icon(
                          Icons.video_camera_front_rounded,
                          size: 32.0,
                          color: Theme.of(context).cardColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
