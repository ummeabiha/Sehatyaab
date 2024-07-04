import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sehatyaab/models/Appointments.dart';
import 'package:sehatyaab/services/FirestoreService.dart';
import 'package:sehatyaab/theme/AppColors.dart';
import 'package:sehatyaab/widgets/BottomNavbar.dart';
import 'package:sehatyaab/widgets/CustomAppBar.dart';
import 'package:sehatyaab/widgets/CustomContainer.dart';
import 'package:sehatyaab/widgets/ElevatedButton.dart';
import '../../models/Doctor.dart';
import '../DisplayAppointments/DoctorPanelHeader.dart';
import '../DoctorDetails/DoctorDetails.dart';
import '../VideoCall/VideoCall.dart';
import '../../globals.dart';

class BookedAppointment extends StatefulWidget {
  const BookedAppointment({super.key});

  @override
  _BookedAppointmentState createState() => _BookedAppointmentState();
}

class _BookedAppointmentState extends State<BookedAppointment> {
  int _currentIndex = 2;
  final FirestoreService<Appointment> _appointmentService =
      FirestoreService<Appointment>('appointments');
  final FirestoreService<Doctor> _doctorService =
      FirestoreService<Doctor>('doctors');
  final _appointmentsSubject = BehaviorSubject<List<Appointment>>();
  final Map<String, Doctor> _doctorCache = {};

  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchAppointments();
    });
    //_listenToAppointments();
  }

  @override
  void dispose() {
    _appointmentsSubject.close();
    super.dispose();
  }

  void _fetchAppointments() {
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

      List<Future<void>> doctorFetchTasks = [];
      for (var appointment in appointments) {
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
      if (mounted) {
        _appointmentsSubject.add(appointments);
        isAppBooked = appointments.isNotEmpty;
      }
    });
  }

  void _cancelAppointment(String id) {
    final updateData = {
      'status': false,
    };
    _appointmentService.updateItem(id, updateData);
  }

  void _viewDoctorInfo(Doctor doctor) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => DoctorDetails(doctor: doctor),
      ),
    );
  }

  void _onBottomNavTap(int index) {
    setState(() {
      _currentIndex = index;
    });
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
            StreamBuilder<List<Appointment>>(
              stream: _appointmentsSubject.stream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  isAppBooked = false;
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                final appointments = snapshot.data;
                if (appointments == null || appointments.isEmpty) {
                  isAppBooked = false;
                  return const SizedBox(
                    height: 200.0,
                    child: Center(child: Text('No Appointment Scheduled.')),
                  );
                } else {
                  isAppBooked = true;
                  return Column(
                    children: appointments.map((appointment) {
                      return Column(
                        children: [
                          CustomElevatedButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => VideoCall(
                                    userID: globalPatientId!,
                                    userName: globalPatientEmail!,
                                    appointmentID: appointment.id,
                                  ),
                                ),
                              );
                            },
                            label: 'Join Call',
                            removeUpperBorders: true,
                            blueColor: true,
                          ),
                          CustomContainer(
                            child: Column(
                              children: [
                                const SizedBox(height: 10),
                                ListTile(
                                  tileColor: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? AppColors.gray1
                                      : AppColors.blue1,
                                  leading: Icon(
                                    Icons.calendar_month_outlined,
                                    size: 32.0,
                                    color: Theme.of(context).cardColor,
                                  ),
                                  title: Text(appointment.date,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium),
                                ),
                                const SizedBox(height: 20),
                                ListTile(
                                  tileColor: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? AppColors.gray1
                                      : AppColors.blue1,
                                  leading: Icon(
                                    Icons.timer,
                                    size: 32.0,
                                    color: Theme.of(context).cardColor,
                                  ),
                                  title: Text(appointment.time,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium),
                                ),
                                const SizedBox(height: 20),
                                ListTile(
                                  tileColor: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? AppColors.gray1
                                      : AppColors.blue1,
                                  leading: Icon(
                                    Icons.healing,
                                    size: 32.0,
                                    color: Theme.of(context).cardColor,
                                  ),
                                  title: Text(
                                    appointment.reasonForVisit,
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                    maxLines: 1,
                                    overflow: TextOverflow.fade,
                                  ),
                                ),
                                const SizedBox(height: 25),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Expanded(
                                      child: CustomElevatedButton(
                                        onPressed: () {
                                          _cancelAppointment(appointment.id);
                                        },
                                        label: 'Cancel',
                                        blueColor: true,
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                    Expanded(
                                      child: CustomElevatedButton(
                                        onPressed: () {
                                          _viewDoctorInfo(_doctorCache[
                                              appointment.doctorId]!);
                                        },
                                        label: 'Doctor',
                                        blueColor: true,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                              ],
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  );
                }
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
