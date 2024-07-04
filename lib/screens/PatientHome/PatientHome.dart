// import 'package:flutter/material.dart';
// import 'package:sehatyaab/models/Doctor.dart';
// import 'package:sehatyaab/routes/AppRoutes.dart';
// import 'package:sehatyaab/widgets/BottomNavbar.dart';
// import '../../services/FirestoreService.dart';
// import '../../theme/AppColors.dart';
// import '../../widgets/CustomAppBar.dart';
// import '../../widgets/CustomContainer.dart';

// class PatientHomeScreen extends StatefulWidget {
//   final FirestoreService<Doctor> firestoreService;
//   const PatientHomeScreen({super.key, required this.firestoreService});

//   @override
//   _PatientHomeScreenState createState() => _PatientHomeScreenState();
// }

// class _PatientHomeScreenState extends State<PatientHomeScreen> {
//   int _currentIndex = 0;

//   void _onBottomNavTap(int index) {
//     setState(() {
//       _currentIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: const CustomAppBar(),
//       body: StreamBuilder<List<Doctor>>(
//         stream: widget.firestoreService.getItemsStream(Doctor(
//           id: '',
//           name: '',
//           email: '',
//           gender: '',
//           dob: '',
//           specialization: '',
//           qualification: '',
//           yearsOfExperience: 0,
//           availableSlots: [],
//           bookedSlots: [],
//         )),
//         builder: (context, AsyncSnapshot<List<Doctor>> snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return _buildBody([]);
//           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return _buildBody([]);
//           } else {
//             return _buildBody(snapshot.data!);
//           }
//         },
//       ),
//       bottomNavigationBar: BottomNavBar(
//         currentIndex: _currentIndex,
//         onTap: _onBottomNavTap,
//       ),
//     );
//   }

//   Widget _buildBody(List<Doctor> doctors) {
//     return SingleChildScrollView(
//       child: Column(
//         children: [
//           AppBar(
//             toolbarHeight: 70.0,
//             title: const Text('Hi 👋, how are you doing ?'),
//             backgroundColor: Theme.of(context).brightness != Brightness.dark
//                 ? Theme.of(context).primaryColor
//                 : Colors.transparent,
//           ),
//           const SizedBox(height: 6.0),
//           CustomContainer(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Container(
//                     padding: const EdgeInsets.all(10.0),
//                     decoration: BoxDecoration(
//                       color: Theme.of(context).cardColor,
//                       borderRadius: BorderRadius.circular(15.0),
//                     ),
//                     child: ListTile(
//                       title: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             "Your Health is Important to Us",
//                             style: Theme.of(context)
//                                 .textTheme
//                                 .bodyLarge
//                                 ?.copyWith(
//                                     fontSize: 24,
//                                     color: Theme.of(context).primaryColor),
//                           ),
//                           const SizedBox(height: 8),
//                           Text(
//                             "Choose the doctor !",
//                             style: Theme.of(context)
//                                 .textTheme
//                                 .bodySmall
//                                 ?.copyWith(
//                                     color: Theme.of(context).primaryColor),
//                           ),
//                         ],
//                       ),
//                       trailing: const Image(
//                         image: AssetImage('assets/images/female.png'),
//                         width: 80,
//                       ),
//                     )),
//                 const SizedBox(height: 18),
//                 const Row(
//                   children: [
//                     SizedBox(width: 12.0),
//                     Text(
//                       'Categories',
//                       style:
//                           TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 3),
//                 const Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     Expanded(
//                       child: CategoryCard(
//                         icon: Icons.local_hospital_rounded,
//                         label: 'General Physician',
//                       ),
//                     ),
//                     Expanded(
//                       child: CategoryCard(
//                         icon: Icons.child_friendly_rounded,
//                         label: 'Child Specialist',
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 10),
//                 Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 12.0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         const Text(
//                           'Popular Doctors',
//                           style: TextStyle(
//                               fontWeight: FontWeight.bold, fontSize: 22),
//                         ),
//                         TextButton(
//                           onPressed: () {
//                             Navigator.pushNamed(context, AppRoutes.doctorList);
//                           },
//                           child: Text(
//                             'See all',
//                             style: Theme.of(context)
//                                 .textTheme
//                                 .bodySmall
//                                 ?.copyWith(fontSize: 18.0),
//                           ),
//                         ),
//                       ],
//                     )),
//                 const SizedBox(height: 10),
//                 ListView.builder(
//                   shrinkWrap: true,
//                   physics: const NeverScrollableScrollPhysics(),
//                   itemCount: 5,
//                   itemBuilder: (BuildContext context, int index) {
//                     var doctor = doctors[index];

//                     String avatarImagePath =
//                         (doctor.gender).toLowerCase() == 'male'
//                             ? 'assets/images/male.png'
//                             : 'assets/images/female.png';

//                     Color tileColor;
//                     if (Theme.of(context).brightness == Brightness.dark) {
//                       tileColor =
//                           index % 2 == 0 ? AppColors.gray1 : Colors.transparent;
//                     } else {
//                       tileColor = index % 2 == 0
//                           ? Theme.of(context).primaryColor
//                           : Colors.white;
//                     }

//                     return Material(
//                       elevation: 4.0,
//                       color: tileColor,
//                       shadowColor: Colors.black45,
//                       borderRadius: BorderRadius.circular(8.0),
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(
//                             vertical: 8.0, horizontal: 16.0),
//                         child: ListTile(
//                           leading: CircleAvatar(
//                             radius: 25,
//                             backgroundColor: AppColors.blue2,
//                             backgroundImage: AssetImage(avatarImagePath),
//                           ),
//                           title: Text(
//                             doctor.name.isNotEmpty ? doctor.name : 'Unknown',
//                             style: Theme.of(context)
//                                 .textTheme
//                                 .bodyMedium
//                                 ?.copyWith(
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 19.0),
//                           ),
//                           subtitle: Text(
//                             doctor.specialization,
//                             style: Theme.of(context)
//                                 .textTheme
//                                 .bodySmall
//                                 ?.copyWith(fontSize: 16.0),
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                 )
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class CategoryCard extends StatelessWidget {
//   final IconData icon;
//   final String label;

//   const CategoryCard({
//     super.key,
//     required this.icon,
//     required this.label,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 150,
//       width: 100,
//       margin: const EdgeInsets.all(12.0),
//       padding: const EdgeInsets.all(12.0),
//       decoration: BoxDecoration(
//         color: Theme.of(context).cardColor,
//         borderRadius: BorderRadius.circular(15.0),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Container(
//             width: 50,
//             height: 50,
//             decoration: const BoxDecoration(
//               shape: BoxShape.circle,
//               color: AppColors.blue1,
//             ),
//             child: Icon(
//               icon,
//               color: AppColors.pink,
//               size: 30,
//             ),
//           ),
//           const SizedBox(height: 8.0),
//           Text(
//             label,
//             style: Theme.of(context).textTheme.bodySmall?.copyWith(
//                 color: Theme.of(context).primaryColor,
//                 fontWeight: FontWeight.w500),
//             textAlign: TextAlign.center,
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:sehatyaab/models/Doctor.dart';
import 'package:sehatyaab/routes/AppRoutes.dart';
import 'package:sehatyaab/widgets/BottomNavbar.dart';
import '../../globals.dart';
import '../../models/Appointments.dart';
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
  final FirestoreService<Appointment> _appointmentService =
      FirestoreService<Appointment>('appointments');

  @override
  void initState() {
    super.initState();
    _checkAppointmentStatus();
  }

  void _checkAppointmentStatus() async {
    var appointments = await _appointmentService
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
        .first;

    appointments = appointments
        .where((appointment) => appointment.status == true)
        .toList();

    if (appointments.isNotEmpty) {
      setState(() {
        isAppBooked = true;
      });
    }
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
          availableSlots: [],
          bookedSlots: [],
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
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: ListTile(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Your Health is Important to Us",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(
                                    fontSize: 24,
                                    color: Theme.of(context).primaryColor),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Choose the doctor !",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                    color: Theme.of(context).primaryColor),
                          ),
                        ],
                      ),
                      trailing: const Image(
                        image: AssetImage('assets/images/female.png'),
                        width: 80,
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
                const SizedBox(height: 10),
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
                                ?.copyWith(fontSize: 18.0),
                          ),
                        ),
                      ],
                    )),
                const SizedBox(height: 10),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 5,
                  itemBuilder: (BuildContext context, int index) {
                    var doctor = doctors[index];

                    String avatarImagePath =
                        (doctor.gender).toLowerCase() == 'male'
                            ? 'assets/images/male.png'
                            : 'assets/images/female.png';

                    Color tileColor;
                    if (Theme.of(context).brightness == Brightness.dark) {
                      tileColor =
                          index % 2 == 0 ? AppColors.gray1 : Colors.transparent;
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
                        ),
                      ),
                    );
                  },
                )
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
    super.key,
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
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(15.0),
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
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
