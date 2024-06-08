import 'package:sehatyaab/models/base_model.dart';

class Doctor extends BaseModel {
  String name;
  String email;
  String gender;
  String dob;
  String specialization;
  String qualification;
  int yearsOfExperience;

  Doctor({
    required super.id,
    required this.name,
    required this.email,
    required this.gender,
    required this.dob,
    required this.specialization,
    required this.qualification,
    required this.yearsOfExperience,
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
    };
  }

  @override
  Doctor fromMap(Map<String, dynamic> map, String id) {
    return Doctor(
      id: id,
      name: map['name'] as String,
      email: map['email'] as String,
      gender: map['gender'] as String,
      dob: map['dob'] as String,
      specialization: map['specialization'] as String,
      qualification: map['qualification'] as String,
      yearsOfExperience: map['yearsOfExperience'] as int,
    );
  }

  @override
  String toString() {
    return 'Doctor(doctorId:$id, name: $name, email: $email, gender: $gender, dob: $dob, specialization: $specialization, qualification: $qualification, yearsOfExperience: $yearsOfExperience)';
  }
}
