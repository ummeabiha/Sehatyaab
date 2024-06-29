import 'package:sehatyaab/models/BaseModel.dart';

class Doctor extends BaseModel {
  String name;
  String email;
  String gender;
  String? dob;
  String specialization;
  String qualification;
  int yearsOfExperience;
  Map<String, List<String>>? availableSlots;
  Map<String, List<String>>? bookedSlots;

  Doctor({
    required super.id,
    required this.name,
    required this.email,
    required this.gender,
    this.dob,
    required this.specialization,
    required this.qualification,
    required this.yearsOfExperience,
    this.availableSlots,
    this.bookedSlots,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'gender': gender,
      'dob': dob,
      'specialization': specialization,
      'qualification': qualification,
      'yearsOfExperience': yearsOfExperience,
      'availableSlots': availableSlots,
      'bookedSlots': bookedSlots,
    };
  }

  @override
  Doctor fromMap(Map<String, dynamic> map, String id) {
    return Doctor(
      id: id ,
      name: map['name'] as String,
      email: map['email'] as String,
      gender: map['gender'] as String,
      dob: map['dob'] as String,
      specialization: map['specialization'] as String,
      qualification: map['qualification'] as String,
      yearsOfExperience: map['yearsOfExperience'] as int,
      availableSlots: map['availableSlots'] != null ? Map<String, List<String>>.from(map['availableSlots']) : null,
      bookedSlots: map['bookedSlots'] != null ? Map<String, List<String>>.from(map['bookedSlots']) : null,
    );
  }

  Doctor copyWith({
    String? name,
    String? email,
    String? gender,
    String? dob,
    String? specialization,
    String? qualification,
    int? yearsOfExperience,
    Map<String, List<String>>? availableSlots,
    Map<String, List<String>>? bookedSlots,
  }) {
    return Doctor(
      id: id,
      name: name ?? this.name,
      email: email ?? this.email,
      gender: gender ?? this.gender,
      dob: dob ?? this.dob,
      specialization: specialization ?? this.specialization,
      qualification: qualification ?? this.qualification,
      yearsOfExperience: yearsOfExperience ?? this.yearsOfExperience,
      availableSlots: availableSlots ?? this.availableSlots,
      bookedSlots: bookedSlots ?? this.bookedSlots,
    );
  }

  @override
  String toString() {
    return 'Doctor(doctorId:$id, name: $name, email: $email, gender: $gender, dob: $dob, specialization: $specialization, qualification: $qualification, yearsOfExperience: $yearsOfExperience, availableSlots: $availableSlots, bookedSlots: $bookedSlots)';
  }
}