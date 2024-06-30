class ProfileFormValidator {
  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is Required';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is Required';
    }
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return 'Invalid Email Address';
    }
    return null;
  }

  static String? validateGender(String? value) {
    if (value == null) {
      return 'Gender is Required';
    }
    return null;
  }

  static String? validateDob(String? value) {
    if (value == null || value.isEmpty) {
      return 'Date of Birth is Required';
    }
    DateTime? dob = DateTime.tryParse(value);
    if (dob == null) {
      return 'Invalid Date Format';
    }
    DateTime now = DateTime.now();
    int age = now.year - dob.year;
    if (now.month < dob.month ||
        (now.month == dob.month && now.day < dob.day)) {
      age--;
    }
    if (age < 0 || age > 100) {
      return 'Age Range Should Be 0 - 100';
    }
    return null;
  }

  static String? validateDocDob(String? value) {
    if (value == null || value.isEmpty) {
      return 'Date of Birth is Required';
    }
    DateTime? dob = DateTime.tryParse(value);
    if (dob == null) {
      return 'Invalid Date Format';
    }
    DateTime now = DateTime.now();
    int age = now.year - dob.year;
    if (now.month < dob.month ||
        (now.month == dob.month && now.day < dob.day)) {
      age--;
    }
    if (age < 18 || age > 100) {
      return 'Age Range Should Be 18 - 100';
    }
    return null;
  }

  static String? validateHeight(String? value) {
    if (value == null || value.isEmpty) {
      return 'Required';
    }
    double? height = double.tryParse(value);
    if (height == null || height < 20 || height > 110) {
      return 'Invalid Height';
    }
    return null;
  }

  static String? validateWeight(String? value) {
    if (value == null || value.isEmpty) {
      return 'Required';
    }
    double? weight = double.tryParse(value);
    if (weight == null || weight < 2 || weight > 300) {
      return 'Invalid Weight';
    }
    return null;
  }

  static String? validateMedicalHistoryType(
      String? value, bool hasMedicalHistory) {
    if (hasMedicalHistory && (value == null || value.isEmpty)) {
      return 'Type is Required';
    }
    return null;
  }

  static String? validateMedicalHistoryDesc(
      String? value, bool hasMedicalHistory) {
    if (hasMedicalHistory && (value == null || value.isEmpty)) {
      return 'Description is Required';
    }
    return null;
  }

  static String? validateMedicalHistoryYear(
      String? value, bool hasMedicalHistory) {
    if (hasMedicalHistory && (value == null || value.isEmpty)) {
      return 'Year is Required';
    }
    if (hasMedicalHistory) {
      int? year = int.tryParse(value!);
      if (year == null) {
        return 'Invalid Year';
      }
      DateTime now = DateTime.now();
      if (year < 1920 || year > now.year) {
        return 'Invalid Year';
      }
    }
    return null;
  }

  static String? validateFamilyHistoryType(
      String? value, bool hasFamilyHistory) {
    if (hasFamilyHistory && (value == null || value.isEmpty)) {
      return 'Type is Required';
    }
    return null;
  }

  static String? validateFamilyHistoryDesc(
      String? value, bool hasFamilyHistory) {
    if (hasFamilyHistory && (value == null || value.isEmpty)) {
      return 'Description is Required';
    }
    return null;
  }

  static String? validateOngoingMedications(
      String? value, bool hasOngoingMedications) {
    if (hasOngoingMedications && (value == null || value.isEmpty)) {
      return 'Medications is Required';
    }
    return null;
  }

  static String? validateSpecialization(String? value) {
    if (value == null || value.isEmpty) {
      return 'Specialization is Required';
    }
    return null;
  }

  static String? validateQualification(String? value) {
    if (value == null || value.isEmpty) {
      return 'Qualification is Required';
    }
    return null;
  }

  static String? validateYearsOfExperience(String? value, String? dobString) {
    if (value == null || value.isEmpty) {
      return 'Required';
    }
    int? experience = int.tryParse(value);
    if (experience == null || experience < 0) {
      return 'Invalid Experience';
    }

    DateTime? dob = DateTime.tryParse(dobString ?? '');
    if (dob == null) {
      return 'Invalid Date of Birth';
    }

    DateTime now = DateTime.now();
    int age = now.year - dob.year;
    if (now.month < dob.month ||
        (now.month == dob.month && now.day < dob.day)) {
      age--;
    }

    if (experience > (age - 18)) {
      return 'Invalid Experience';
    }

    return null;
  }
}
