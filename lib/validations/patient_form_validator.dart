class PatientFormValidator {
  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter patient name';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter patient email';
    }
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  static String? validateGender(String? value) {
    if (value == null) {
      return 'Please select gender';
    }
    return null;
  }

static String? validateDob(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select date of birth';
    }
    DateTime? dob = DateTime.tryParse(value);
    if (dob == null) {
      return 'Invalid date format';
    }
    DateTime now = DateTime.now();
    int age = now.year - dob.year;
    if (now.month < dob.month ||
        (now.month == dob.month && now.day < dob.day)) {
      age--;
    }
    if (age < 0 || age > 100) {
      return 'Age must be between 0 and 100';
    }
    return null;
  }

 static String? validateHeight(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter height';
    }
    double? height = double.tryParse(value);
    if (height == null || height <= 20 || height >=110) {
      return 'Please enter a valid even height in inches';
    }
    return null;
  }

  static String? validateWeight(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter weight';
    }
    double? weight = double.tryParse(value);
    if (weight == null || weight <= 2 || weight>=300) {
      return 'Please enter a valid even weight in kilograms';
    }
    return null;
  }

  static String? validateMedicalHistoryType(
      String? value, bool hasMedicalHistory) {
    if (hasMedicalHistory && (value == null || value.isEmpty)) {
      return 'Please enter medical history type';
    }
    return null;
  }

  static String? validateMedicalHistoryDesc(
      String? value, bool hasMedicalHistory) {
    if (hasMedicalHistory && (value == null || value.isEmpty)) {
      return 'Please enter medical history description';
    }
    return null;
  }

  static String? validateMedicalHistoryYear(
      String? value, bool hasMedicalHistory) {
    if (hasMedicalHistory && (value == null || value.isEmpty)) {
      return 'Please enter medical history year';
    }
    if (hasMedicalHistory && int.tryParse(value!) == null) {
      return 'Please enter a valid year';
    }
    return null;
  }

  static String? validateFamilyHistoryType(
      String? value, bool hasFamilyHistory) {
    if (hasFamilyHistory && (value == null || value.isEmpty)) {
      return 'Please enter family history type';
    }
    return null;
  }

  static String? validateFamilyHistoryDesc(
      String? value, bool hasFamilyHistory) {
    if (hasFamilyHistory && (value == null || value.isEmpty)) {
      return 'Please enter family history description';
    }
    return null;
  }

  static String? validateOngoingMedications(
      String? value, bool hasOngoingMedications) {
    if (hasOngoingMedications && (value == null || value.isEmpty)) {
      return 'Please enter ongoing medications';
    }
    return null;
  }
}
