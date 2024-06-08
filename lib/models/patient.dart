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
  Patient fromMap(Map<String, dynamic> map, String id) {
    return Patient(
      id: id,
      name: map['name'] as String,
      email: map['email'] as String,
      age: map['age'] as int,
      gender: map['gender'] as String,
      dob: map['dob'] as String,
      isBpPatient: map['isBpPatient'] as bool? ?? false,
      isSugarPatient: map['isSugarPatient'] as bool? ?? false,
      height: map['height'] as double,
      weight: map['weight'] as double,
      medicalHistoryType: map['medicalHistoryType'] as String?,
      medicalHistoryDesc: map['medicalHistoryDesc'] as String?,
      medicalHistoryYear: map['medicalHistoryYear'] as int?,
      familyHistoryType: map['familyHistoryType'] as String?,
      familyHistoryDesc: map['familyHistoryDesc'] as String?,
      ongoingMedications: map['ongoingMedications'] as String?,
    );
  }

  @override
  String toString() {
    return 'Patient(id:$id, name: $name, email: $email, age: $age, gender: $gender, dob: $dob, isBpPatient: $isBpPatient, isSugarPatient: $isSugarPatient, height: $height, weight: $weight, medicalHistoryType: $medicalHistoryType, medicalHistoryDesc: $medicalHistoryDesc, medicalHistoryYear: $medicalHistoryYear, familyHistoryType: $familyHistoryType, familyHistoryDesc: $familyHistoryDesc, ongoingMedications: $ongoingMedications)';
  }
}
