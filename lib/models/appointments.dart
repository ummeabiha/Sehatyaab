import 'package:sehatyaab/models/BaseModel.dart';

class Appointment extends BaseModel {
  String date;
  String time;
  String patientId;
  String doctorId;
  String reasonForVisit;
  bool status;
  String? diagnosis;
  String? prescribedMeds;
  String? prescribedTests;

  Appointment({
    required super.id,
    required this.date,
    required this.time,
    required this.patientId,
    required this.doctorId,
    required this.reasonForVisit,
    this.status = false,
    this.diagnosis,
    this.prescribedMeds,
    this.prescribedTests,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date,
      'time': time,
      'patientId': patientId,
      'doctorId': doctorId,
      'reasonForVisit': reasonForVisit,
      'status': status,
      'diagnosis': diagnosis,
      'prescribedMeds': prescribedMeds,
      'prescribedTests': prescribedTests,
    };
  }

  @override
  Appointment fromMap(Map<String, dynamic> map, String id) {
    return Appointment(
      id: id,
      date: map['date'] as String? ?? '',
      time: map['time'] as String? ?? '',
      patientId: map['patientId'] as String? ?? '',
      doctorId: map['doctorId'] as String? ?? '',
      reasonForVisit: map['reasonForVisit'] as String? ?? '',
      status: map['status'] as bool? ?? false,
      diagnosis: map['diagnosis'] as String?,
      prescribedMeds: map['prescribedMeds'] as String?,
      prescribedTests: map['prescribedTests'] as String?,
    );
  }

  @override
  String toString() {
    return 'Appointment(appointmentId: $id, date: $date, time: $time, patientId: $patientId, doctorId: $doctorId, reasonForVisit: $reasonForVisit, status: $status, diagnosis: $diagnosis, prescribedMeds: $prescribedMeds, prescribedTests: $prescribedTests)';
  }
}
