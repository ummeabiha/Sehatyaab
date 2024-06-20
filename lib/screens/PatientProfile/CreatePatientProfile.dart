import 'package:flutter/material.dart';
import 'package:sehatyaab/validations/PatientFormValidator.dart';
import 'package:sehatyaab/widgets/CustomAppBar.dart';
import 'package:sehatyaab/widgets/ElevatedButton.dart';
import 'package:sehatyaab/widgets/FormContainer.dart';
import 'package:sehatyaab/widgets/RoundedContainer.dart';
import 'package:sehatyaab/widgets/TextFormField.dart';
import 'package:sehatyaab/widgets/TopImage.dart';
import 'package:sehatyaab/widgets/dropdown.dart';
import '../../widgets/DatePicker.dart';
import 'PatientHistory.dart';
import 'package:firebase_auth/firebase_auth.dart';


class CreatePatientProfile extends StatefulWidget {
  const CreatePatientProfile({Key? key}) : super(key: key);

  @override
  _PatientFormState createState() => _PatientFormState();
}

class _PatientFormState extends State<CreatePatientProfile> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  String? _gender;
  final _genders = ['Male', 'Female', 'Other'];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TopImage(),
            RoundedContainer(
              child: FormContainer(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Create Patient Profile',
                        style: Theme.of(context).brightness== Brightness.dark? Theme.of(context).textTheme.bodyLarge : Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context).primaryColor,
                ),
                      ),
                      const SizedBox(
                        height: 24.0,
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
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextFormField(
                              controller: _weightController,
                              validator: PatientFormValidator.validateWeight,
                              labelText: 'Weight',
                              hintText: '2-300 (kgs)',
                            ),
                          ),
                          const SizedBox(
                            width: 20.0,
                          ),
                          Expanded(
                            child: CustomTextFormField(
                              controller: _heightController,
                              validator: PatientFormValidator.validateHeight,
                              labelText: 'Height',
                              hintText: '20-110 (inches)',
                            ),
                          ),
                        ],
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
                                    'id': FirebaseAuth.instance.currentUser!.uid,
                                    'name': _nameController.text,
                                    'email': _emailController.text,
                                    'gender': _gender!,
                                    'dob': _dobController.text,
                                    'weight': _weightController.text,
                                    'height': _heightController.text,
                                  },
                                ),
                              ),
                            );
                          }
                        },
                        label: 'Continue',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
