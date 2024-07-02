import 'package:sehatyaab/models/BaseModel.dart';

class Patient extends BaseModel {
  String name;
  String email;
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
    required super.id,
    required this.name,
    required this.email,
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
      gender: map['gender'] as String,
      dob: map['dob'] as String,
      isBpPatient: map['isBpPatient'] as bool? ?? false,
      isSugarPatient: map['isSugarPatient'] as bool? ?? false,
      height: (map['height'] as num).toDouble(),
      weight: (map['weight'] as num).toDouble(),
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
    return 'Patient(id: $id, name: $name, email: $email, gender: $gender, dob: $dob, isBpPatient: $isBpPatient, isSugarPatient: $isSugarPatient, height: $height, weight: $weight, medicalHistoryType: $medicalHistoryType, medicalHistoryDesc: $medicalHistoryDesc, medicalHistoryYear: $medicalHistoryYear, familyHistoryType: $familyHistoryType, familyHistoryDesc: $familyHistoryDesc, ongoingMedications: $ongoingMedications)';
  }

  toList() {}
}
