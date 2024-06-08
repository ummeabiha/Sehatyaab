import 'package:sehatyaab/models/base_model.dart';

class Patient extends BaseModel {
  String? id;
  String name;
  String email;
  int age;
  String gender;
  String dob;
  bool isBpPatient;
  bool isSugarPatient;
  double height;
  double weight;
  String? medicalHistoryType;
  String? medicalHistoryDesc;
  int? medicalHistoryYear;
  String? familyHistoryType;
  String? familyHistoryDesc;
  String? ongoingMedications;

  Patient({
    this.id,
    required this.name,
    required this.email,
    required this.age,
    required this.gender,
    required this.dob,
    this.isBpPatient = false,
    this.isSugarPatient = false,
    required this.height,
    required this.weight,
    this.medicalHistoryType,
    this.medicalHistoryDesc,
    this.medicalHistoryYear,
    this.familyHistoryType,
    this.familyHistoryDesc,
    this.ongoingMedications,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'age': age,
      'gender': gender,
      'dob': dob,
      'isBpPatient': isBpPatient,
      'isSugarPatient': isSugarPatient,
      'height': height,
      'weight': weight,
      'medicalHistoryType': medicalHistoryType,
      'medicalHistoryDesc': medicalHistoryDesc,
      'medicalHistoryYear': medicalHistoryYear,
      'familyHistoryType': familyHistoryType,
      'familyHistoryDesc': familyHistoryDesc,
      'ongoingMedications': ongoingMedications,
    };
  }

  @override
  BaseModel fromMap(Map<String, dynamic> map, String id) {
    return Patient(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      age: map['age'],
      gender: map['gender'],
      dob: map['dob'],
      isBpPatient: map['isBpPatient'] ?? false,
      isSugarPatient: map['isSugarPatient'] ?? false,
      height: map['height'],
      weight: map['weight'],
      medicalHistoryType: map['medicalHistoryType'],
      medicalHistoryDesc: map['medicalHistoryDesc'],
      medicalHistoryYear: map['medicalHistoryYear'],
      familyHistoryType: map['familyHistoryType'],
      familyHistoryDesc: map['familyHistoryDesc'],
      ongoingMedications: map['ongoingMedications'],
    );
  }

  @override
  String toString() {
    return 'Patient(id:$id, name: $name, email: $email, age: $age, gender: $gender, dob: $dob, isBpPatient: $isBpPatient, isSugarPatient: $isSugarPatient, height: $height, weight: $weight, medicalHistoryType: $medicalHistoryType, medicalHistoryDesc: $medicalHistoryDesc, medicalHistoryYear: $medicalHistoryYear, familyHistoryType: $familyHistoryType, familyHistoryDesc: $familyHistoryDesc, ongoingMedications: $ongoingMedications)';
  }
}
