import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/appointments.dart';
import '../models/doctor.dart';
import 'package:sehatyaab/models/base_model.dart';
import '../services/FirestoreService.dart';

class AppointmentProvider with ChangeNotifier {
  final FirestoreService<Appointment> _appointmentService =
  FirestoreService<Appointment>('appointments');
  final FirestoreService<Doctor> _doctorService =
  FirestoreService<Doctor>('doctors');

  Stream<List<Doctor>>? _doctorsStream;

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
    final dateTime = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    final formatter = DateFormat.jm(); // Use whatever format you need
    return formatter.format(dateTime);
  }

  Future<void> bookAppointment(
      String doctorId, String patientId, String reasonForVisit) async {
    try {
      _doctorsStream = _doctorService.getItemsStream(
        Doctor(
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
        ),
      );

      _doctorsStream!.listen((List<Doctor> doctors) async {
        Doctor? doctor = doctors.firstWhere((doc) => doc.id == doctorId);

        if (doctor != null) {
          final Map<String, List<String>> availableSlots = doctor.availableSlots;
          final Map<String, List<String>> bookedSlots = doctor.bookedSlots;

          final DateFormat formatter = DateFormat('yyyy-MM-dd');
          final String formattedDate = formatter.format(selectedDate!);

          if (availableSlots.containsKey(formattedDate)) {
            final List<String> slotsForDate = availableSlots[formattedDate]!;
            final String formattedTime = _formatTimeOfDay(selectedTime!);

            if (slotsForDate.contains(formattedTime)) {
              // Update available and booked slots
              slotsForDate.remove(formattedTime);
              bookedSlots.putIfAbsent(formattedDate, () => []).add(formattedTime);

              // Update doctor object with modified slots (Option a)
              Doctor updatedDoctor = doctor.copyWith(
                availableSlots: availableSlots,
                bookedSlots: bookedSlots,
              );

              // doctor.availableSlots = availableSlots;
              // doctor.bookedSlots = bookedSlots;

              await _doctorService.updateItem(doctorId, updatedDoctor); // Use updatedDoctor

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
      });
    } catch (e) {
      debugPrint('Error booking appointment: $e');
      rethrow;
    }
  }

  // Dispose the stream when no longer needed
  void dispose() {
    _doctorsStream?.drain();
    super.dispose();
  }
}
