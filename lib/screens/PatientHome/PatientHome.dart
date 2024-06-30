import 'package:flutter/material.dart';
import 'package:sehatyaab/constants.dart';
import 'package:sehatyaab/models/Doctor.dart';
import 'package:sehatyaab/routes/AppRoutes.dart';
import 'package:sehatyaab/widgets/BottomNavbar.dart';
import '../../services/FirestoreService.dart';
import '../../theme/AppColors.dart';
import '../../widgets/CustomAppBar.dart';
import '../../widgets/CustomContainer.dart';

class PatientHomeScreen extends StatefulWidget {
  final FirestoreService<Doctor> firestoreService;
  const PatientHomeScreen({super.key, required this.firestoreService});

  @override
  _PatientHomeScreenState createState() => _PatientHomeScreenState();
}

class _PatientHomeScreenState extends State<PatientHomeScreen> {
  int _currentIndex = 0;

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
          availableSlots: {},
          bookedSlots: {},
        )),
        builder: (context, AsyncSnapshot<List<Doctor>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return _buildBody([]);
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return _buildBody([]);
          } else {
            return _buildBody(snapshot.data!);
          }
        },
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onBottomNavTap,
      ),
    );
  }

  Widget _buildBody(List<Doctor> doctors) {
    return SingleChildScrollView(
      child: Column(
        children: [
          AppBar(
            toolbarHeight: 70.0,
            title: const Text('Hi 👋, how are you doing ?'),
            backgroundColor: Theme.of(context).brightness != Brightness.dark
                ? Theme.of(context).primaryColor
                : Colors.transparent,
          ),
          const SizedBox(height: 6.0),
          CustomContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: AppColors.blue4,
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: const ListTile(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Your Health is Important to Us",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(
                              height:
                                  8), // Add space between title and subtitle
                          Text(
                            "Choose the doctor you want !",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      trailing: Image(
                        image: AssetImage('assets/images/hearPulse.png'),
                        width: 50,
                      ),
                    )),
                const SizedBox(height: 18),
                const Row(
                  children: [
                    SizedBox(width: 12.0),
                    Text(
                      'Categories',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                    ),
                  ],
                ),
                const SizedBox(height: 3),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: CategoryCard(
                        icon: Icons.local_hospital_rounded,
                        label: 'General Physician',
                      ),
                    ),
                    Expanded(
                      child: CategoryCard(
                        icon: Icons.child_friendly_rounded,
                        label: 'Child Specialist',
                      ),
                    ),
                  ],
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Popular Doctors',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 22),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, AppRoutes.doctorList);
                          },
                          child: Text(
                            'See all',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(fontSize: 16.0),
                          ),
                        ),
                      ],
                    )),
                const SizedBox(height: 10),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: doctors.length,
                  itemBuilder: (BuildContext context, int index) {
                    var doctor = doctors[index];

                    return Container(
                      margin: const EdgeInsets.only(bottom: 10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        border:
                            Border.all(width: 1.5, color: Colors.grey.shade300),
                      ),
                      child: ListTile(
                        leading: const CircleAvatar(
                          radius: 25,
                          backgroundImage:
                              AssetImage('assets/images/female.png'),
                        ),
                        title: Text(
                          doctor.name,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              doctor.specialization,
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            const Row(
                              children: [
                                Icon(Icons.star,
                                    size: 18, color: Colors.amberAccent),
                                Icon(Icons.star,
                                    size: 18, color: Colors.amberAccent),
                                Icon(Icons.star,
                                    size: 18, color: Colors.amberAccent),
                                Icon(Icons.star,
                                    size: 18, color: Colors.amberAccent),
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
              ],
            ),
          ),
        ],
      ),
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
      width: 100,
      margin: const EdgeInsets.all(12.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: AppColors.blue4,
        borderRadius: BorderRadius.circular(15.0),
        //border: Border.all(width: 1.5, color: Theme.of(context).cardColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.blue1,
            ),
            child: Icon(
              icon,
              color: AppColors.pink,
              size: 30,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            label,
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(color: AppColors.blue1),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
