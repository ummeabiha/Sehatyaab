import 'package:flutter/material.dart';
import 'package:sehatyaab/validations/patient_form_validator.dart';
import 'package:sehatyaab/widgets/ElevatedButton.dart';
import 'package:sehatyaab/widgets/MainContainer.dart';
import 'package:sehatyaab/widgets/TextFormField.dart';
import 'package:sehatyaab/widgets/dropdown.dart';
import '../../widgets/DatePicker.dart';
import 'PatientHistory.dart';

class CreatePatientProfile extends StatefulWidget {
  const CreatePatientProfile({super.key});

  @override
  _PatientFormState createState() => _PatientFormState();
}

class _PatientFormState extends State<CreatePatientProfile> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  String? _gender;
  final _genders = ['Male', 'Female', 'Other'];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: MainContainer(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Create Patient Profile',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(
                height: 35.0,
              ),
              CustomTextFormField(
                controller: _nameController,
                validator: PatientFormValidator.validateName,
                labelText: 'Patient Name',
                hintText: 'Enter Patient Name',
                suffixIcon: Icons.person,
              ),
              const SizedBox(
                height: 28.0,
              ),
              CustomTextFormField(
                controller: _emailController,
                validator: PatientFormValidator.validateEmail,
                labelText: 'Patient Email',
                hintText: 'Enter Patient Email',
                suffixIcon: Icons.email,
              ),
              const SizedBox(
                height: 28.0,
              ),
              CustomDropdown<String>(
                value: _gender,
                decoration: InputDecoration(
                  labelText: 'Patient Gender',
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
              const SizedBox(
                height: 28.0,
              ),
              DatePickerField(
                controller: _dobController,
                labelText: 'Date of Birth',
                hintText: 'Select Date of Birth',
                validator: PatientFormValidator.validateDob,
              ),
              const SizedBox(
                height: 28.0,
              ),
              CustomElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PatientHistory(
                          patientData: {
                            'name': _nameController.text,
                            'email': _emailController.text,
                            'gender': _gender!,
                            'dob': _dobController.text,
                          },
                        ),
                      ),
                    );
                  }
                },
                label: 'Continue',
              )
            ],
          ),
        ),
      ),
    );
  }
}
