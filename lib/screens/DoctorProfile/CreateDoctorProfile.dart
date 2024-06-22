import 'package:flutter/material.dart';
import '../../models/Doctor.dart';
import '../../theme/AppColors.dart';
import '../../validations/PatientFormValidator.dart';
import '../../widgets/DatePicker.dart';
import '../../widgets/DropDown.dart';
import '../../widgets/ElevatedButton.dart';
import '../../widgets/FormContainer.dart';
import '../../widgets/TextFormField.dart';
import '../../services/FirestoreService.dart';
import '../../widgets/CustomAppBar.dart';

class CreateDoctorProfile extends StatefulWidget {
  final Map<String, dynamic> doctorData;

  const CreateDoctorProfile(
      {super.key,
      required this.doctorData,
      required FirestoreService<Doctor> firestoreService});

  @override
  _CreateDoctorProfileState createState() => _CreateDoctorProfileState();
}

class _CreateDoctorProfileState extends State<CreateDoctorProfile> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _specializationController =
      TextEditingController();
  final TextEditingController _qualificationController =
      TextEditingController();
  final TextEditingController _yearsOfExperienceController =
      TextEditingController();
  String? _gender;
  final _genders = ['Male', 'Female', 'Other'];

  void _saveDoctorData() {
    if (_formKey.currentState!.validate()) {
      Doctor doctor = Doctor(
        id: widget.doctorData['id'],
        name: _nameController.text,
        email: _emailController.text,
        gender: _gender!,
        dob: _dobController.text,
        specialization: _specializationController.text,
        qualification: _qualificationController.text,
        yearsOfExperience: int.parse(_yearsOfExperienceController.text),
      );

      // FirestoreService('doctors').addItem(doctor).then((_) {
      // ScaffoldMessenger.of(context).showSnackBar(
      //    const SnackBar(content: Text('Information saved successfully')),
      //  );
      FirestoreService<Doctor>('doctors')
          .updateItem(doctor.id, doctor.toMap())
          .then((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Information updated successfully')),
        );
        Navigator.pop(context); // Go back to the home screen or previous screen
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save information: $error')),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(),
        body: SingleChildScrollView(
            child: Container(
          color: Theme.of(context).brightness == Brightness.dark
              ? AppColors.black2
              : Theme.of(context).cardColor,
          child: FormContainer(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 220.0,
                    child: Image.asset('assets/images/profile.png'),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Text('Create Doctor Profile',
                      style: Theme.of(context).brightness == Brightness.dark
                          ? Theme.of(context).textTheme.bodyLarge
                          : Theme.of(context).textTheme.bodyLarge?.copyWith(
                                color: Theme.of(context).primaryColor,
                              )),
                  const SizedBox(height: 40.0),
                  CustomTextFormField(
                    controller: _nameController,
                    validator: PatientFormValidator.validateName,
                    labelText: 'Doctor Name',
                    hintText: 'Enter Doctor Name',
                    suffixIcon: Icons.person,
                  ),
                  const SizedBox(height: 30.0),
                  CustomTextFormField(
                    controller: _emailController,
                    validator: PatientFormValidator.validateEmail,
                    keyboardType: TextInputType.emailAddress,
                    labelText: 'Doctor Email',
                    hintText: 'Enter Doctor Email',
                    suffixIcon: Icons.email,
                  ),
                  const SizedBox(height: 30.0),
                  CustomDropdown<String>(
                    value: _gender,
                    decoration: InputDecoration(
                      labelText: 'Gender',
                      labelStyle: Theme.of(context).textTheme.bodySmall,
                    ),
                    items: _genders.map((String gender) {
                      return DropdownMenuItem<String>(
                        value: gender,
                        child: Text(gender),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _gender = newValue;
                      });
                    },
                    validator: PatientFormValidator.validateGender,
                  ),
                  const SizedBox(height: 30.0),
                  DatePickerField(
                    controller: _dobController,
                    labelText: 'Date of Birth',
                    hintText: 'Select Date of Birth',
                    validator: PatientFormValidator.validateDob,
                  ),
                  const SizedBox(height: 30.0),
                  CustomTextFormField(
                    controller: _specializationController,
                    validator: PatientFormValidator.validateSpecialization,
                    labelText: 'Specialization',
                    hintText: 'Enter Specialization',
                    suffixIcon: Icons.work,
                  ),
                  const SizedBox(height: 30.0),
                  CustomTextFormField(
                    controller: _qualificationController,
                    validator: PatientFormValidator.validateQualification,
                    labelText: 'Qualification',
                    hintText: 'Enter Qualification',
                    suffixIcon: Icons.school,
                  ),
                  const SizedBox(height: 30.0),
                  CustomTextFormField(
                    controller: _yearsOfExperienceController,
                    validator: PatientFormValidator.validateYearsOfExperience,
                    labelText: 'Years of Experience',
                    hintText: 'Enter Years of Experience',
                    suffixIcon: Icons.calendar_today,
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 40),
                  CustomElevatedButton(
                    onPressed: _saveDoctorData,
                    label: 'Save',
                  ),
                ],
              ),
            ),
          ),
        )));
  }
}
