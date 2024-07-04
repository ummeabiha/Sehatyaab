import 'package:flutter/material.dart';
import 'package:sehatyaab/services/FirestoreService.dart';
import 'package:sehatyaab/models/Doctor.dart';
import 'package:sehatyaab/screens/Appointments/AppointmentForm.dart';
import 'package:sehatyaab/widgets/CustomAppBar.dart';

import '../../widgets/BottomNavbar.dart';
import '../../widgets/ElevatedButton.dart';

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
      appBar: const CustomAppBar(),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        //color: AppColors.blue4,
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
      // child: Container(
      //   decoration: BoxDecoration(
      //     gradient: LinearGradient(
      //       colors: [Colors.white, Colors.grey.shade200],
      //       begin: Alignment.topLeft,
      //       end: Alignment.bottomRight,
      //     ),
      //     boxShadow: [
      //       BoxShadow(
      //         color: Theme.of(context).cardColor.withOpacity(0.3),
      //         spreadRadius: 2,
      //         blurRadius: 7,
      //         offset: Offset(0, 2), // changes position of shadow
      //       ),
      //     ],
      //     borderRadius: BorderRadius.circular(10),
      //   ),

      child: Card(
        color: Theme.of(context).primaryColor,
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              ListTile(
                // leading: CircleAvatar(
                //   radius: 50,
                //   backgroundColor: Colors.grey[800],
                //   child: Text(
                //     doctor.name.isNotEmpty ? doctor.name.substring(0, 1) : '',
                //     style: const TextStyle(fontSize: 30, color: Colors.blueAccent),
                //   ),
                // ),
                title: Center(
                  child: Text(
                    doctor.name,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                subtitle: Center(
                  child: Text(
                    doctor.specialization,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              ),
              Divider(
                color: Theme.of(context).cardColor,
                //height: 10,
                thickness: 1,
                indent: 16,
                endIndent: 16,
              ),
              ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                title: Text(
                  'Description & Services',
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    'Email: ${doctor.email}\nGender: ${doctor.gender}\nDate of Birth: ${doctor.dob}\nQualification: ${doctor.qualification}\nYears of Experience: ${doctor.yearsOfExperience}',
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(height: 1.5, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Center(
                child: CustomElevatedButton(
                  blueColor: true,
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
                  // style: ElevatedButton.styleFrom(
                  //   backgroundColor: AppColors.blue4,
                  //   padding: const EdgeInsets.symmetric(
                  //       horizontal: 50, vertical: 15),
                  //   textStyle: const TextStyle(
                  //     color: Colors.white,
                  //     fontSize: 18,
                  //     fontWeight: FontWeight.bold,
                  //   ),
                  //   shape: RoundedRectangleBorder(
                  //     borderRadius: BorderRadius.circular(30),
                  //   ),
                  // ),
                  label: 'Book Now',
                ),
              ),
            ],
          ),
        ),
      ),
      //),
    );
  }
}
