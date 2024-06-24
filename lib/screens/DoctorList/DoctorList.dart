import 'package:flutter/material.dart';
import 'package:sehatyaab/constants.dart';
import 'package:sehatyaab/models/Doctor.dart';
import 'package:sehatyaab/routes/AppRoutes.dart';
import 'package:sehatyaab/widgets/BottomNavbar.dart';
import '../../services/FirestoreService.dart';
import '../../widgets/CustomAppBar.dart';

class DoctorList extends StatefulWidget {
  final FirestoreService<Doctor> firestoreService;
  const DoctorList({super.key, required this.firestoreService});

  @override
  _DoctorListState createState() => _DoctorListState();
}

class _DoctorListState extends State<DoctorList> {
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

              return Scaffold(
                  appBar: AppBar(
                    title: Center(child: Text("Doctors")),
                    backgroundColor: kPrimaryLightColor,
                  ),
                  body: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: doctors.length,
                          itemBuilder: (BuildContext context, int index) {
                            var doctor = doctors[index];

                            return Container(
                              margin: EdgeInsets.all(4.0),
                              padding: EdgeInsets.all(4.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.0),
                                  border: Border.all(
                                      width: 1.5, color: Colors.grey.shade300)),
                              child: ListTile(
                                leading: const CircleAvatar(
                                  radius: 25,
                                  backgroundImage:
                                      AssetImage('assets/images/female.png'),
                                ),
                                title: Text(
                                  doctor.name,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      doctor.specialization,
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Icon(Icons.star,
                                            size: 18,
                                            color: Colors.amberAccent),
                                        Icon(Icons.star,
                                            size: 18,
                                            color: Colors.amberAccent),
                                        Icon(Icons.star,
                                            size: 18,
                                            color: Colors.amberAccent),
                                        Icon(Icons.star,
                                            size: 18, color: Colors.amberAccent)
                                      ],
                                    ),
                                  ],
                                ),
                                trailing: TextButton(
                                  onPressed: () {
                                    // Implement booking functionality
                                  },
                                  child: const Text("Book Now",
                                      style: TextStyle(color: kPrimaryColor)),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ]),
                  ));
            }
          },
        ));
  }
}
