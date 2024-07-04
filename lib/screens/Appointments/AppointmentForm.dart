import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sehatyaab/globals.dart';
import 'package:sehatyaab/widgets/CustomAppBar.dart';
import '../../Providers/AppointmentProvider.dart';
import '../../routes/AppRoutes.dart';
import '../../theme/AppColors.dart';
import '../../widgets/BottomNavbar.dart';
import '../../widgets/CustomContainer.dart';
import '../../widgets/CustomStyledTextField.dart';
import '../../widgets/ElevatedButton.dart';
import '../DisplayAppointments/DoctorPanelHeader.dart';

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
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const DoctorPanelHeader(
            imagePath: 'assets/images/book.png',
            text: 'Appointment Booking',
          ),
          // Container(
          //   padding: const EdgeInsets.all(8.0),
          //   color: AppColors.blue4,
          //   child: const Center(
          //     child: Text(
          //       'Book An Appointment For:',
          //       style: TextStyle(
          //         fontSize: 18,
          //         fontWeight: FontWeight.bold,
          //         color: Colors.black,
          //       ),
          //     ),
          //   ),
          // ),

          Padding(
            padding: const EdgeInsets.only(top: 20.0, bottom: 8.0),
            child: Center(
              child: Text(widget.selectedDoctor,
                  style: Theme.of(context).textTheme.bodyLarge),
            ),
          ),
          //const SizedBox(height: 10),

          CustomContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text(
                //   'Select Date:',
                //   style: Theme.of(context).textTheme.bodyMedium,
                  
                // ),
                // const SizedBox(height: 12),

                Material(
                  elevation: 2.0,
                  borderRadius: BorderRadius.circular(15.0),
                  shadowColor: Colors.black45,
                  child: ListTile(
                    tileColor: Theme.of(context).brightness != Brightness.dark
                        ? AppColors.white
                        : AppColors.gray2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    title: Text(
                      provider.selectedDate == null
                          ? 'Choose a date'
                          : DateFormat.yMMMd()
                              .format(DateTime.parse(provider.selectedDate!)),
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    trailing: Icon(
                      Icons.calendar_today,
                      color: Theme.of(context).cardColor,
                    ),
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
                ),

                // ListTile(

                //   tileColor: Theme.of(context).brightness != Brightness.dark
                //       ? AppColors.white
                //       : AppColors.gray2,
                //   title: Text(
                //     provider.selectedDate == null
                //         ? 'Choose a date'
                //         : DateFormat.yMMMd()
                //             .format(DateTime.parse(provider.selectedDate!)),
                //     style: Theme.of(context).textTheme.bodyMedium,
                //   ),
                //   trailing: Icon(Icons.calendar_today,
                //       color: Theme.of(context).cardColor),
                //   onTap: () async {
                //     DateTime? pickedDate = await showDatePicker(
                //       context: context,
                //       initialDate: DateTime.now(),
                //       firstDate: DateTime.now(),
                //       lastDate: DateTime(2101),
                //     );
                //     if (pickedDate != null) {
                //       provider.selectDate(pickedDate);
                //       provider.fetchAvailableTimes(
                //           widget.selectedDoctorId, pickedDate);
                //     }
                //   },
                // ),
                const SizedBox(height: 14),
                Card(
                  color: Theme.of(context).brightness != Brightness.dark
                      ? AppColors.white
                      : AppColors.gray2,
                  child: ListTile(
                    title: Text(
                      provider.selectedTime == null
                          ? 'Choose a Time'
                          : provider.selectedTime!,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    trailing: Icon(Icons.access_time,
                        color: Theme.of(context).cardColor),
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
                                        title: Text(
                                            provider.availableTimes[index]),
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
                                        fontSize: 20,
                                        //fontWeight: FontWeight.bold,
                                        color: AppColors.red,
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
                const SizedBox(height: 14),
                // const Text(
                //   'Your Symptoms:',
                //   style: TextStyle(
                //     fontSize: 18,
                //     fontWeight: FontWeight.bold,
                //     color: Colors.white,
                //   ),
                // ),
                CustomStyledTextField(
                  controller: _reasonForVisit,
                  labelText: 'Reason For Visit',
                  hintText: 'Reason For Visit',
                  suffixIcon: Icons.health_and_safety,
                ),
                const SizedBox(height: 30),
                Center(
                  child: CustomElevatedButton(
                    blueColor: true,
                    onPressed: () {
                      if (provider.selectedDate == null ||
                          provider.selectedTime == null ||
                          _reasonForVisit.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text('All Fields are Required!',
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

                        Navigator.pushReplacementNamed(
                            context, AppRoutes.bookedAppointment);
                      }
                    },

                    label: 'Book Appointment',
                    // child: const Text('Book Appointment'),
                    // style: ButtonStyle(
                    //   backgroundColor:
                    //       MaterialStateProperty.all<Color>(AppColors.blue4),
                    //   foregroundColor:
                    //       MaterialStateProperty.all<Color>(Colors.white),
                    // ),
                  ),
                ),
              ],
            ),
          ),
        ],
      )),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onBottomNavTap,
      ),
    );
  }
}
