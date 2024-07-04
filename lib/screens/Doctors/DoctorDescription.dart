import 'package:flutter/material.dart';
import 'package:sehatyaab/services/FirestoreService.dart';
import 'package:sehatyaab/theme/AppColors.dart';
import 'package:sehatyaab/models/Doctor.dart';
import 'package:sehatyaab/screens/Appointments/AppointmentForm.dart';
import 'package:sehatyaab/widgets/CustomAppBar.dart';

import '../../widgets/BottomNavbar.dart';

class DoctorDescriptionScreen extends StatefulWidget {
  final FirestoreService<Doctor> firestoreService;

  const DoctorDescriptionScreen(
      {super.key, required this.firestoreService, required});

  @override
  _DoctorDescriptionScreenState createState() =>
      _DoctorDescriptionScreenState();
}

class _DoctorDescriptionScreenState extends State<DoctorDescriptionScreen> {
  int _currentIndex = 3;

  void _onBottomNavTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
        const CustomAppBar(),

      body: Container(
        color: AppColors.blue4,
        child: StreamBuilder<List<Doctor>>(
          stream: widget.firestoreService.getItemsStream(Doctor(
            id: '',
            name: '',
            email: '',
            gender: '',
            dob: '',
            specialization: '',
            qualification: '',
            yearsOfExperience: 0,
            // availableSlots: [],
            // bookedSlots: [],
          )),
          builder: (context, AsyncSnapshot<List<Doctor>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              print('${snapshot.error}');
              return Center(
                  child: Text('Error fetching data  ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No doctors found'));
            } else {
              final doctors = snapshot.data!;
              return ListView.builder(
                itemCount: doctors.length,
                itemBuilder: (BuildContext context, int index) {
                  var doctor = doctors[index];
                  return DoctorListItem(
                      doctor: doctor,
                      firestoreService: widget.firestoreService);
                },
              );
            }
          },
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onBottomNavTap,
      ),
    );
  }
}

class DoctorListItem extends StatelessWidget {
  final Doctor doctor;
  final FirestoreService<Doctor> firestoreService;

  DoctorListItem({required this.doctor, required this.firestoreService});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.grey.shade200],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
          borderRadius: BorderRadius.circular(15),
        ),
        child: Card(
          color: Colors.transparent,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                ListTile(
                  leading: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey[800],
                    child: Text(
                      doctor.name.isNotEmpty ? doctor.name.substring(0, 1) : '',
                      style: const TextStyle(fontSize: 30, color: Colors.blueAccent),
                    ),
                  ),
                  title: Center(
                    child: Text(
                      doctor.name,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: AppColors.blue4,
                      ),
                    ),
                  ),
                  subtitle: Center(
                    child: Text(
                      doctor.specialization,
                      style: const TextStyle(fontSize: 16, color: AppColors.blue2),
                    ),
                  ),
                ),
                const Divider(
                  color: Colors.grey,
                  height: 20,
                  thickness: 1,
                  indent: 16,
                  endIndent: 16,
                ),
                ListTile(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  title: Text(
                    'Description & Services',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      'Email: ${doctor.email}\nGender: ${doctor.gender}\nDate of Birth: ${doctor.dob}\nQualification: ${doctor.qualification}\nYears of Experience: ${doctor.yearsOfExperience}',
                      style: TextStyle(fontSize: 16, height: 1.5),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AppointmentForm(
                            selectedDoctor: doctor.name,
                            selectedDoctorId:
                                doctor.id, // Pass the doctor's ID here
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.blue4,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 15),
                      textStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text('Book Now'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
