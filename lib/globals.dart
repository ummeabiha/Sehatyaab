String? globalDoctorId;
String? globalDoctorEmail;
String? globalPatientId;
String? globalPatientEmail;
bool isAppBooked=false;

int calculateAge(DateTime? birthDate) {
  if (birthDate == null) return 0;

  DateTime today = DateTime.now();
  int age = today.year - birthDate.year;
  if (today.month < birthDate.month ||
      (today.month == birthDate.month && today.day < birthDate.day)) {
    age--;
  }
  return age;
}
