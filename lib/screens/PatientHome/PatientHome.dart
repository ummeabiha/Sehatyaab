import 'package:flutter/material.dart';
import 'package:sehatyaab/constants.dart';
import 'package:sehatyaab/models/doctor.dart';
import 'package:sehatyaab/routes/AppRoutes.dart';
import 'package:sehatyaab/widgets/BottomNavbar.dart';
import '../../services/FirestoreService.dart';

class PatientHomeScreen extends StatefulWidget {
  final FirestoreService<Doctor> firestoreService;
  const PatientHomeScreen({Key? key, required this.firestoreService})
      : super(key: key);

  @override
  _PatientHomeScreenState createState() => _PatientHomeScreenState();
}

class _PatientHomeScreenState extends State<PatientHomeScreen> {
  void _onBottomNavTap(int index) {
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, AppRoutes.patienthp);
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/appointments');
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/doctor');
        break;
      case 3:
        Navigator.pushReplacementNamed(context, '/profile');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Doctor>>(
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
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          print('Error fetching data: ${snapshot.error}');
          return Center(child: Text('Error fetching data'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          print('No doctors found');
          return Center(child: Text('No doctors found'));
        } else {
          final doctors = snapshot.data!;
          print('Doctors fetched: ${doctors.length}');

          return Scaffold(
            appBar: AppBar(
              title: Text('Hi 👋, how are you doing ?'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.circular(15.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: ListTile(
                      title: Text(
                        "Your Health is Important to Us",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      subtitle: Text(
                        "Choose the doctor you want !",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      trailing: Image(
                        image: AssetImage('assets/images/hearPulse.png'),
                        width: 50,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  const Text(
                    'Categories',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  SizedBox(height: 10),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CategoryCard(
                        icon: Icons.local_hospital,
                        label: 'General Physician',
                      ),
                      CategoryCard(
                        icon: Icons.child_care_outlined,
                        label: 'Child Specialist',
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Popular doctors',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      TextButton(
                        onPressed: () {
                          // Navigate to a screen to view all doctors
                        },
                        child: Text(
                          'See all',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                      itemCount: doctors.length,
                      itemBuilder: (BuildContext context, int index) {
                        var doctor = doctors[index];
                        print(
                            'Doctor: ${doctor.name}, ${doctor.email}, ${doctor.dob}');

                        return ListTile(
                          leading: CircleAvatar(
                            radius: 25,
                            backgroundImage:
                                AssetImage('assets/images/female.png'),
                          ),
                          title: Text(doctor.name),
                          subtitle: Text(doctor.specialization),
                          trailing: TextButton(
                            onPressed: () {
                              // Implement booking functionality
                            },
                            child: Text("Book Now"),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            bottomNavigationBar: CustomBottomNavBar(
              currentIndex: 0, // Highlight the home screen
              onTap: _onBottomNavTap,
            ),
          );
        }
      },
    );
  }
}

class CategoryCard extends StatelessWidget {
  final IconData icon;
  final String label;

  const CategoryCard({
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: 120,
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(color: lightPink, boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          blurRadius: 4.0,
          spreadRadius: 0.0,
          offset: Offset(3, 3),
        ),
      ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: Icon(
              icon,
              color: Colors.white,
              size: 40,
            ),
            width: 80,
            height: 70,
            color: pink,
          ),
          SizedBox(height: 15),
          Text(
            label,
            style: TextStyle(fontWeight: FontWeight.w700),
          )
        ],
      ),
    );
  }
}
