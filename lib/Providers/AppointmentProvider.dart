import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/Appointments.dart';
import '../models/Doctor.dart';
import '../services/FirestoreService.dart';

class AppointmentProvider with ChangeNotifier {
  final FirestoreService<Appointment> _appointmentService =
      FirestoreService<Appointment>('/appointments');
  final FirestoreService<Doctor> _doctorService =
      FirestoreService<Doctor>('/doctors');

  String? _selectedDate;
  String? _selectedTime;
  String? _queryOrComment;
  List<String> _availableTimes = [];

  String? get selectedDate => _selectedDate;
  String? get selectedTime => _selectedTime;
  String? get queryOrComment => _queryOrComment;
  List<String> get availableTimes => _availableTimes;

  void selectDate(DateTime date) {
    _selectedDate = DateFormat('yyyy-MM-dd').format(date);
    notifyListeners();
  }

  void selectTime(String time) {
    _selectedTime = time;
    notifyListeners();
  }

  void setQueryOrComment(String queryOrComment) {
    _queryOrComment = queryOrComment;
    notifyListeners();
  }

  void updateAvailableTimes(List<String> times) {
    _availableTimes = times;
    notifyListeners();
  }

  Future<void> fetchAvailableTimes(String doctorId, DateTime date) async {
    try {
      //final String formattedDate = DateFormat('yyyy-MM-dd').format(date);
      Doctor? doctor = await _doctorService.getItemById(
        doctorId,
        Doctor(
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
        ),
      );

      // Use doctor's availableSlots if available
      List<String> availableSlots = doctor.availableSlots ?? [];

      // Only enable these slots for weekdays (Monday to Friday)
      if (date.weekday >= 1 && date.weekday <= 5) {
        _availableTimes = availableSlots; // Update available times for weekdays
      } else {
        _availableTimes = []; // Clear available times for weekends
      }
      notifyListeners();
    } catch (e) {
      debugPrint('Error fetching available times: $e');
      rethrow;
    }
  }

  Future<void> bookAppointment(
      String doctorId, String patientId, String reasonForVisit) async {
    try {
      Doctor? doctor = await _doctorService.getItemById(
        doctorId,
        Doctor(
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
        ),
      );

      final String formattedDate = _selectedDate!;
      final String formattedTime = _selectedTime!;

      // Check if the selected time slot is available
      if (doctor.availableSlots!.contains(formattedTime)) {
        // Update doctor's slots
        List<String> availableSlots =
            List<String>.from(doctor.availableSlots ?? []);
        List<String> bookedSlots = List<String>.from(doctor.bookedSlots ?? []);

        availableSlots.remove(formattedTime);
        bookedSlots.add(formattedTime);

        // Update doctor object with modified slots
        doctor = doctor.copyWith(
          availableSlots: availableSlots,
          bookedSlots: bookedSlots,
        );

        // Update doctor's document in Firestore
        await _doctorService.updateDoctor(doctor);

        // Create appointment object
        final Appointment newAppointment = Appointment(
          id: '',
          date: formattedDate,
          time: formattedTime,
          patientId: patientId,
          doctorId: doctorId,
          reasonForVisit: reasonForVisit,
        );

        // Add appointment to Firestore
        await _appointmentService.addItem(newAppointment);
      } else {
        throw 'Selected time slot is not available';
      }
    } catch (e) {
      debugPrint('Error booking appointment: $e');
      rethrow;
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
