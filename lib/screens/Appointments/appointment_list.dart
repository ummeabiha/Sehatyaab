import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../models/appointments.dart';
import '../../services/FirestoreService.dart';

class AppointmentList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final FirestoreService<Appointment> appointmentService =
    FirestoreService<Appointment>('appointments');

    return Scaffold(
      appBar: AppBar(
        title: Text('Appointments List'),
      ),
      body: StreamBuilder<List<Appointment>>(
        stream: appointmentService.getItemsStream(Appointment(
          id: '',
          date: '',
          time: '',
          patientId: '',
          doctorId: '',
          reasonForVisit: '',
        )),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No appointments found'));
          } else {
            final appointments = snapshot.data!;
            return ListView.builder(
              itemCount: appointments.length,
              itemBuilder: (context, index) {
                final appointment = appointments[index];
                final formattedDate = DateFormat.yMMMd();
                return ListTile(
                  title: Text(appointment.reasonForVisit),
                  subtitle: Text('$formattedDate at ${appointment.time}'),
                  onTap: () {
                    // Handle appointment tap
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
