import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../Providers/appointment_provider.dart';
import '../../theme/AppColors.dart';

class AppointmentForm extends StatelessWidget {
  final String selectedDoctor;
  final String selectedDoctorId;

  AppointmentForm({required this.selectedDoctor, required this.selectedDoctorId});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppointmentProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Book an Appointment', style: TextStyle(color: Colors.white)),
        backgroundColor: AppColors.blue4,
        elevation: 3,
      ),
      body:
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(8.0),
                color: AppColors.blue4,
                child: Text(
                  'Selected Doctor:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  selectedDoctor,
                  style: TextStyle(fontSize: 16),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Select Date:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Card(
                color: Colors.grey[200],
                child: ListTile(
                  title: Text(
                    provider.selectedDate == null
                        ? 'Choose a date'
                        : DateFormat.yMMMd().format(DateTime.parse(provider.selectedDate!)),
                  ),
                  trailing: Icon(Icons.calendar_today, color: AppColors.blue4),
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2101),
                    );
                    if (pickedDate != null) {
                      provider.selectDate(pickedDate);
                      provider.fetchAvailableTimes(selectedDoctorId, pickedDate); // Fetch available times
                    }
                  },
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Select Time:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Card(
                color: Colors.grey[200],
                child: ListTile(
                  title: Text(
                    provider.selectedTime == null
                        ? 'Choose a time'
                        : provider.selectedTime!,
                  ),
                  trailing: Icon(Icons.access_time, color: AppColors.blue4),
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return ListView.builder(
                          itemCount: provider.availableTimes.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(provider.availableTimes[index]),
                              onTap: () {
                                provider.selectTime(provider.availableTimes[index]);
                                Navigator.pop(context);
                              },
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Your Symptoms:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Card(
                color: Colors.grey[200],
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Any symptoms or condition that you feel?',
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                  onChanged: (value) {
                    provider.setQueryOrComment(value);
                  },
                ),
              ),
              SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (provider.selectedDate == null ||
                        provider.selectedTime == null ||
                        provider.queryOrComment == null ||
                        provider.queryOrComment!.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Please fill in all fields')),
                      );
                    } else {
                      provider.bookAppointment(
                        selectedDoctorId,
                        'patient123',
                        'General Checkup',
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text('Appointment booked successfully'),
                            backgroundColor: Colors.blue, ),
                      );
                    }
                  },
                  child: Text('Book Appointment'),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(AppColors.blue4),
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



//------------------------------------------------------------------------------
//
// class AppointmentForm extends StatelessWidget {
//   final String selectedDoctor;
//   final FirestoreService<Doctor> firestoreService;
//
//   AppointmentForm({required this.selectedDoctor,required this.firestoreService});
//
//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<AppointmentProvider>(context);
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Book an Appointment', style: TextStyle(color: Colors.white)),
//         backgroundColor: AppColors.blue4,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'Selected Doctor:',
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 8.0),
//                 child: Text(
//                   selectedDoctor,
//                   style: TextStyle(fontSize: 16),
//                 ),
//               ),
//               SizedBox(height: 20),
//               Text(
//                 'Select Date:',
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//               ListTile(
//                 tileColor: Colors.grey[200],
//                 title: Text(
//                   provider.selectedDate == null
//                       ? 'Choose a date'
//                       : DateFormat.yMMMd().format(provider.selectedDate!),
//                 ),
//                 trailing: Icon(Icons.calendar_today, color: AppColors.blue4),
//                 onTap: () async {
//                   DateTime? pickedDate = await showDatePicker(
//                     context: context,
//                     initialDate: DateTime.now(),
//                     firstDate: DateTime.now(),
//                     lastDate: DateTime(2101),
//                   );
//                   if (pickedDate != null) {
//                     provider.selectDate(pickedDate);
//                   }
//                 },
//               ),
//               SizedBox(height: 20),
//               Text(
//                 'Select Time:',
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//               ListTile(
//                 tileColor: Colors.grey[200],
//                 title: Text(
//                   provider.selectedTime == null
//                       ? 'Choose a time'
//                       : provider.selectedTime!.format(context),
//                 ),
//                 trailing: Icon(Icons.access_time, color: AppColors.blue4),
//                 onTap: () async {
//                   TimeOfDay? pickedTime = await showTimePicker(
//                     context: context,
//                     initialTime: TimeOfDay.now(),
//                   );
//                   if (pickedTime != null) {
//                     provider.selectTime(pickedTime);
//                   }
//                 },
//               ),
//               SizedBox(height: 20),
//               Text(
//                 'Your Symptoms:',
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//               TextField(
//                 decoration: InputDecoration(
//                   hintText: 'ANy symptoms or condition that you feel?',
//                   border: OutlineInputBorder(),
//                   filled: true,
//                   fillColor: Colors.grey[200],
//                 ),
//                 onChanged: (value) {
//                   provider.setQueryOrComment(value);
//                 },
//               ),
//               SizedBox(height: 30),
//               Center(
//                 child: ElevatedButton(
//                   onPressed: () {
//                     if (provider.selectedDate == null ||
//                         provider.selectedTime == null ||
//                         provider.queryOrComment == null ||
//                         provider.queryOrComment!.isEmpty) {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(content: Text('Please fill in all fields')),
//                       );
//                     } else {
//                       provider.bookAppointment(
//                         'patient123',
//                         'doctor456',
//                         'General Checkup',
//                       );
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(content: Text('Appointment booked successfully')),
//                       );
//                     }
//                   },
//                   child: Text('Book Appointment'),
//                   style: ButtonStyle(
//                     backgroundColor: MaterialStateProperty.all<Color>(AppColors.blue4),
//                     foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }