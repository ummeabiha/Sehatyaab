import 'package:flutter/material.dart';
import 'package:sehatyaab/constants.dart';
import 'package:sehatyaab/models/Doctor.dart';
import 'package:sehatyaab/routes/AppRoutes.dart';
import 'package:sehatyaab/widgets/BottomNavbar.dart';
import '../../services/FirestoreService.dart';
import '../../widgets/CustomAppBar.dart';

class PatientHomeScreen extends StatefulWidget {
  final FirestoreService<Doctor> firestoreService;
  const PatientHomeScreen({super.key, required this.firestoreService});

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
        Navigator.pushReplacementNamed(context, '/doctorList');
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/displayPatient');
        break;
      case 3:
        Navigator.pushReplacementNamed(context, '/doctorProfile');
        break;
    }
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

              return Scaffold(
                appBar: AppBar(
                  title: const Text('Hi 👋, how are you doing ?'),
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
                        ),
                        child: const ListTile(
                          title: Text(
                            "Your Health is Important to Us",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
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
                      const SizedBox(height: 20),
                      const Text(
                        'Categories',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      const SizedBox(height: 10),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          CategoryCard(
                            icon: Icons.local_hospital_rounded,
                            label: 'General Physician',
                          ),
                          CategoryCard(
                            icon: Icons.child_friendly_rounded,
                            label: 'Child Specialist',
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Popular doctors',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          TextButton(
                            onPressed: () {
                              // Navigate to a screen to view all doctors
                            },
                            child: const Text(
                              'See all',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: kPrimaryColor),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Expanded(
                        child: ListView.builder(
                          itemCount: 5,
                          itemBuilder: (BuildContext context, int index) {
                            var doctor = doctors[index];

                            return Container(
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
        ));
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
      height: 120,
      width: 180,
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(15.0),
          border: Border.all(width: 1.5, color: Colors.grey.shade300)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              child: Icon(
                icon,
                color: pink,
                size: 30,
              ),
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: lightPink,
                borderRadius: BorderRadius.circular(15.0),
              )),
          SizedBox(height: 15),
          Text(
            label,
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
          )
        ],
      ),
    );
  }
}
