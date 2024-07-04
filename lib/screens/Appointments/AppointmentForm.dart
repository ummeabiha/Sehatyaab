import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sehatyaab/globals.dart';
import 'package:sehatyaab/widgets/CustomAppBar.dart';
import '../../Providers/AppointmentProvider.dart';
import '../../routes/AppRoutes.dart';
import '../../theme/AppColors.dart';
import '../../widgets/BottomNavbar.dart';
import '../../widgets/CustomStyledTextField.dart';

class AppointmentForm extends StatefulWidget {
  final String selectedDoctor;
  final String selectedDoctorId;

  const AppointmentForm({
    super.key,
    required this.selectedDoctor,
    required this.selectedDoctorId,
  });

  @override
  _AppointmentFormState createState() => _AppointmentFormState();
}

class _AppointmentFormState extends State<AppointmentForm> {
  int _currentIndex = 3;
  final _reasonForVisit = TextEditingController();

  void _onBottomNavTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppointmentProvider>(context);

    return Scaffold(
      appBar: CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(8.0),
                color: AppColors.blue4,
                child: const Center(
                  child: Text(
                    'Book An Appointment For:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
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
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Select Date:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
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
                    provider.fetchAvailableTimes(
                        widget.selectedDoctorId, pickedDate);
                  }
                },
              ),
              const SizedBox(height: 20),
              Card(
                color: Colors.grey[200],
                child: ListTile(
                  title: Text(
                    provider.selectedTime == null
                        ? 'Choose a time'
                        : provider.selectedTime!,
                  ),
                  trailing:
                      const Icon(Icons.access_time, color: AppColors.blue4),
                  onTap: () async {
                    if (provider.selectedDate != null) {
                      await provider.fetchAvailableTimes(
                        widget.selectedDoctorId,
                        DateTime.parse(provider.selectedDate!),
                      );
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return provider.availableTimes.isNotEmpty
                              ? ListView.builder(
                                  itemCount: provider.availableTimes.length,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      title:
                                          Text(provider.availableTimes[index]),
                                      onTap: () {
                                        provider.selectTime(
                                            provider.availableTimes[index]);
                                        Navigator.pop(context);
                                      },
                                    );
                                  },
                                )
                              : Center(
                                  child: Text(
                                    provider.availabilityMessage ?? '',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red,
                                    ),
                                  ),
                                );
                        },
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text('Please select a date first',
                                style: Theme.of(context).textTheme.bodySmall),
                            backgroundColor: AppColors.blue2),
                      );
                    }
                  },
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Your Symptoms:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              CustomStyledTextField(
                controller: _reasonForVisit,
                labelText: 'Reason For Visit',
                hintText: 'Reason For Visit',
                suffixIcon: Icons.health_and_safety,
              ),
              const SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (provider.selectedDate == null ||
                        provider.selectedTime == null ||
                        _reasonForVisit.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text('Please fill in all fields',
                            style: Theme.of(context).textTheme.bodySmall),
                            backgroundColor: AppColors.blue2),
                      );
                    } else {
                      provider.bookAppointment(
                        widget.selectedDoctorId,
                        globalPatientId!,
                        _reasonForVisit.text,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text('Appointment booked successfully',
                                style: Theme.of(context).textTheme.bodySmall),
                            backgroundColor: AppColors.blue2),
                      );

                      Navigator.pushReplacementNamed(context, AppRoutes.bookedAppointment);
                    }
                  },

                  child: const Text('Book Appointment'),
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
