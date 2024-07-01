import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../providers/AppointmentProvider.dart';
import '../../theme/AppColors.dart';
import '../../widgets/BottomNavbar.dart';

class AppointmentForm extends StatefulWidget {
  final String selectedDoctor;
  final String selectedDoctorId;

  const AppointmentForm(
      {super.key,
      required this.selectedDoctor,
      required this.selectedDoctorId});

  @override
  _AppointmentFormState createState() => _AppointmentFormState();
}

class _AppointmentFormState extends State<AppointmentForm> {
  int _currentIndex = 3;

  void _onBottomNavTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppointmentProvider>(context);

    return Scaffold(
      // Scaffold setup remains the same
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(8.0),
                color: AppColors.blue4,
                child: const Center(
                  child: const Text(
                    'Book An Appointment For:',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Center(
                  child: Text(
                    widget.selectedDoctor,
                    style: const TextStyle(
                        fontSize: 26,
                        color: AppColors.blue4,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Select Date:',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              ListTile(
                tileColor: Colors.grey[200],
                title: Text(
                  provider.selectedDate == null
                      ? 'Choose a date'
                      : DateFormat.yMMMd()
                          .format(DateTime.parse(provider.selectedDate!)),
                ),
                trailing:
                    const Icon(Icons.calendar_today, color: AppColors.blue4),
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2101),
                  );
                  if (pickedDate != null) {
                    provider.selectDate(pickedDate);
                    // Fetch available times for the selected doctor and date
                    provider.fetchAvailableTimes(
                        widget.selectedDoctorId, pickedDate);
                  }
                },
              ),
              SizedBox(height: 20),
              Card(
                color: Colors.grey[200],
                child: ListTile(
                  title: Text(
                    provider.selectedTime == null
                        ? 'Choose a time'
                        : provider.selectedTime!,
                  ),
                  trailing: Icon(Icons.access_time, color: AppColors.blue4),
                  onTap: () async {
                    // Ensure available times are fetched before showing modal bottom sheet
                    if (provider.selectedDate != null) {
                      await provider.fetchAvailableTimes(
                          widget.selectedDoctorId,
                          DateTime.parse(provider.selectedDate!));
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return ListView.builder(
                            itemCount: provider.availableTimes.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(provider.availableTimes[index]),
                                onTap: () {
                                  provider.selectTime(
                                      provider.availableTimes[index]);

                                  provider.bookAppointment(
                                    widget.selectedDoctorId,
                                    'patient123', // Replace with actual patient ID
                                    'General Checkup', // Replace with actual reason
                                  );
                                  Navigator.pop(context);
                                },
                              );
                            },
                          );
                        },
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Please select a date first')),
                      );
                    }
                  },
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Your Symptoms:',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Card(
                color: Colors.grey[200],
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Any symptoms or condition that you feel?',
                    border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: AppColors.blue2, width: 2.0),
                    ),
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
                        widget.selectedDoctorId,
                        'patient123',
                        'General Checkup',
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Appointment booked successfully'),
                          backgroundColor: Colors.blue,
                        ),
                      );
                    }
                  },
                  child: Text('Book Appointment'),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(AppColors.blue4),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onBottomNavTap,
      ),
    );
  }
}
