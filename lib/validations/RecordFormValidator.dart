class RecordFormValidator {
  static String? validateCommaSeparated(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  static String? validateDiagnosis(String? value) {
    return validateCommaSeparated(value);
  }

  static String? validateMeds(String? value) {
    return validateCommaSeparated(value);
  }

}
