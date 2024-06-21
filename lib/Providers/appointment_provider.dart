import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/appointments.dart';
import '../models/doctor.dart';
import '../services/FirestoreService.dart';

class AppointmentProvider with ChangeNotifier {
  final FirestoreService<Appointment> _appointmentService =
  FirestoreService<Appointment>('appointments');
  final FirestoreService<Doctor> _doctorService =
  FirestoreService<Doctor>('doctors');

  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  String? _queryOrComment;

  DateTime? get selectedDate => _selectedDate;
  TimeOfDay? get selectedTime => _selectedTime;
  String? get queryOrComment => _queryOrComment;

  void selectDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }

  void selectTime(TimeOfDay time) {
    _selectedTime = time;
    notifyListeners();
  }

  void setQueryOrComment(String queryOrComment) {
    _queryOrComment = queryOrComment;
    notifyListeners();
  }

  String _formatTimeOfDay(TimeOfDay time) {
    final now = DateTime.now();
    final dateTime =
    DateTime(now.year, now.month, now.day, time.hour, time.minute);
    final formatter = DateFormat.jm(); // Use whatever format you need
    return formatter.format(dateTime);
  }

  Future<void> bookAppointment(
      String doctorId, String patientId, String reasonForVisit) async {
    try {
      final doctor = await _doctorService.getItem(doctorId);

      if (doctor != null) {
        final Map<String, List<String>> availableSlots = doctor.availableSlots;
        final Map<String, List<String>> bookedSlots = doctor.bookedSlots;

        final DateFormat formatter = DateFormat('yyyy-MM-dd');
        final String formattedDate = formatter.format(selectedDate!);

        if (availableSlots.containsKey(formattedDate)) {
          final List<String> slotsForDate = availableSlots[formattedDate]!;
          final String formattedTime = _formatTimeOfDay(selectedTime!);

          if (slotsForDate.contains(formattedTime)) {
            slotsForDate.remove(formattedTime);
            bookedSlots.putIfAbsent(formattedDate, () => []).add(formattedTime);

            await _doctorService.updateItem(doctorId, doctor.copyWith(
              availableSlots: availableSlots,
              bookedSlots: bookedSlots,
            ));

            final Appointment newAppointment = Appointment(
              id: '',
              date: selectedDate!,
              time: formattedTime,
              patientId: patientId,
              doctorId: doctorId,
              reasonForVisit: reasonForVisit,
            );

            await _appointmentService.addItem(newAppointment);
          } else {
            throw 'Selected time slot is not available';
          }
        } else {
          throw 'No available slots for selected date';
        }
      } else {
        throw 'Doctor not found';
      }
    } catch (e) {
      debugPrint('Error booking appointment: $e');
      rethrow;
    }
  }
}
