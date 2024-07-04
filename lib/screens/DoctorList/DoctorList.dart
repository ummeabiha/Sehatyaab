import 'package:flutter/material.dart';
import 'package:sehatyaab/models/Doctor.dart';
import '../../globals.dart';
import '../../services/FirestoreService.dart';
import '../../theme/AppColors.dart';
import '../../widgets/AlertDialogBox.dart';
import '../../widgets/BottomNavbar.dart';
import '../../widgets/CustomAppBar.dart';
import '../DisplayAppointments/DoctorPanelHeader.dart';

class DoctorList extends StatefulWidget {
  final FirestoreService<Doctor> firestoreService;

  const DoctorList({super.key, required this.firestoreService});

  @override
  _DoctorListState createState() => _DoctorListState();
}

class _DoctorListState extends State<DoctorList> {
  int _currentIndex = 1;

  void _onBottomNavTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: StreamBuilder<List<Doctor>>(
        stream: widget.firestoreService.getItemsStream(Doctor(
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
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            print('Error fetching data: ${snapshot.error}');
            return const Center(child: Text('Error fetching data'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            print('No doctors found');
            return const Center(child: Text('No doctors found'));
          } else {
            final doctors = snapshot.data!;
            print('Doctors fetched: ${doctors.length}');

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const DoctorPanelHeader(
                    imagePath: 'assets/images/doctors.png', text: 'Doctors'),
                Expanded(
                  child: ListView.builder(
                    itemCount: doctors.length,
                    itemBuilder: (BuildContext context, int index) {
                      var doctor = doctors[index];

                      String avatarImagePath =
                          (doctor.gender).toLowerCase() == 'male'
                              ? 'assets/images/male.png'
                              : 'assets/images/female.png';

                      Color tileColor;
                      if (Theme.of(context).brightness == Brightness.dark) {
                        tileColor = index % 2 == 0
                            ? AppColors.gray1
                            : Colors.transparent;
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
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 16.0),
                          child: ListTile(
                            leading: CircleAvatar(
                              radius: 25,
                              backgroundColor: AppColors.blue2,
                              backgroundImage: AssetImage(avatarImagePath),
                            ),
                            title: Text(
                              doctor.name.isNotEmpty ? doctor.name : 'Unknown',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 19.0),
                            ),
                            subtitle: Text(
                              doctor.specialization,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(fontSize: 16.0),
                            ),
                            trailing: OutlinedButton(
                              onPressed: () {
                                if (isAppBooked == false) {
                                  Navigator.pushReplacementNamed(
                                      context, '/doctordesc');
                                } else {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return const AlertDialogBox(
                                        title: 'Appointment Conflict',
                                        content:
                                            'You Already Have a Scheduled Appointment.',
                                      );
                                    },
                                  );
                                  //});
                                }
                              },
                              child: Text(
                                'Book',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(fontSize: 14.0),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onBottomNavTap,
      ),
    );
  }
}
