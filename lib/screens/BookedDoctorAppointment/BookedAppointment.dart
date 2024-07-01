import 'dart:async';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sehatyaab/globals.dart';
import 'package:sehatyaab/screens/PatientAppointments/DoctorPanelHeader.dart';
import 'package:sehatyaab/widgets/CustomAppBar.dart';
import 'package:sehatyaab/widgets/CustomContainer.dart';
import '../../models/Doctor.dart';
import '../../models/Appointments.dart';
import '../../services/FirestoreService.dart';
import '../../theme/AppColors.dart';
import '../../widgets/BottomNavbar.dart';
import '../../widgets/ElevatedButton.dart';
import '../VideoCall/VideoCall.dart';

class BookedAppointment extends StatefulWidget {
  const BookedAppointment({super.key});

  @override
  _BookedAppointmentState createState() => _BookedAppointmentState();
}

class _BookedAppointmentState extends State<BookedAppointment> {
  int _currentIndex = 2;

  void _onBottomNavTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  final FirestoreService<Appointment> _appointmentService =
      FirestoreService<Appointment>('appointments');
  final FirestoreService<Doctor> _doctorService =
      FirestoreService<Doctor>('doctors');

  String appointmentId = '';
  final _appointmentsSubject = BehaviorSubject<List<Appointment>>();
  final Map<String, Doctor> _doctorCache = {};

  void _listenToAppointments() async {
    debugPrint(globalPatientId!);

    List<Future<void>> doctorFetchTasks = [];

    _appointmentService
        .getItemsByPatientIdStream(
      globalPatientId!,
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
      appointments = appointments
          .where((appointment) => appointment.status == true)
          .toList();
      for (var appointment in appointments) {
        appointmentId = appointment.id;
        if (!_doctorCache.containsKey(appointment.doctorId)) {
          doctorFetchTasks.add(
            _doctorService
                .getItemById(
              appointment.doctorId,
              Doctor(
                id: '',
                name: '',
                email: '',
                gender: '',
                specialization: '',
                qualification: '',
                yearsOfExperience: 0,
              ),
            )
                .then((doctor) {
              _doctorCache[appointment.doctorId] = doctor;
            }),
          );
        }
      }
      await Future.wait(doctorFetchTasks);
      _appointmentsSubject.add(appointments);
    });
  }

  @override
  void initState() {
    super.initState();
    _listenToAppointments();
  }

  @override
  void dispose() {
    _appointmentsSubject.close();
    super.dispose();
  }

  void _cancelAppointment(String id) {
    debugPrint('Cancel appointment ${id}');
    final updateData = {
      'status': false,
    };
    _appointmentService.updateItem(id, updateData);
  }

  void _viewDoctorInfo(Doctor doctor) {
    // Navigator.of(context).push(
    //   MaterialPageRoute(
    //     builder: (context) => DoctorProfile(
    //         doctor: doctor), // Pass the doctor info to the profile page
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const DoctorPanelHeader(
              imagePath: 'assets/images/scheduledApp.png',
              text: 'Scheduled Appointment',
            ),
            CustomElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => VideoCall(
                      userID: globalPatientId!,
                      userName: globalPatientEmail!,
                      appointmentID: appointmentId,
                    ),
                  ),
                );
              },
              label: 'Join Call',
              removeUpperBorders: true,
              blueColor: true,
            ),
            StreamBuilder<List<Appointment>>(
              stream: _appointmentsSubject.stream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                final appointments = snapshot.data;
                if (appointments == null || appointments.isEmpty) {
                  return const SizedBox(
                      height: 200.0,
                      child: Center(child: Text('No Appointment Scheduled.')));
                }

                return CustomContainer(
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      ListTile(
                        tileColor:
                            Theme.of(context).brightness == Brightness.dark
                                ? AppColors.gray1
                                : AppColors.blue1,
                        leading: Icon(
                          Icons.calendar_month_outlined,
                          size: 32.0,
                          color: Theme.of(context).cardColor,
                        ),
                        title: Text(appointments[0].date,
                            style: Theme.of(context).textTheme.bodyMedium),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ListTile(
                        tileColor:
                            Theme.of(context).brightness == Brightness.dark
                                ? AppColors.gray1
                                : AppColors.blue1,
                        leading: Icon(
                          Icons.timer,
                          size: 32.0,
                          color: Theme.of(context).cardColor,
                        ),
                        title: Text(appointments[0].time,
                            style: Theme.of(context).textTheme.bodyMedium),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ListTile(
                        tileColor:
                            Theme.of(context).brightness == Brightness.dark
                                ? AppColors.gray1
                                : AppColors.blue1,
                        leading: Icon(
                          Icons.healing,
                          size: 32.0,
                          color: Theme.of(context).cardColor,
                        ),
                        title: Text(
                          appointments[0].reasonForVisit,
                          style: Theme.of(context).textTheme.bodyMedium,
                          maxLines: 1,
                          overflow: TextOverflow.fade,
                        ),
                      ),
                      const SizedBox(height: 25),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: CustomElevatedButton(
                              onPressed: () {
                                _cancelAppointment(appointments[0].id);
                              },
                              label: 'Cancel',
                              blueColor: true,
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: CustomElevatedButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => VideoCall(
                                      userID: globalPatientId!,
                                      userName: globalPatientEmail!,
                                      appointmentID: appointmentId,
                                    ),
                                  ),
                                );
                              },
                              label: 'See Doctor',
                              blueColor: true,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onBottomNavTap,
      ),
    );
  }
}
