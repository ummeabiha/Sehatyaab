import 'package:flutter/material.dart';
import 'package:sehatyaab/theme/AppColors.dart';
import 'package:sehatyaab/validations/PatientFormValidator.dart';
import 'package:sehatyaab/widgets/CustomAppBar.dart';
import 'package:sehatyaab/widgets/ElevatedButton.dart';
import 'package:sehatyaab/widgets/FormContainer.dart';
import 'package:sehatyaab/widgets/TextFormField.dart';
import 'package:sehatyaab/widgets/dropdown.dart';
import '../../widgets/DatePicker.dart';
import 'PatientHistory.dart';

class CreatePatientProfile extends StatefulWidget {
  final Map<String, dynamic> patientData;
  
  const CreatePatientProfile({super.key, required this.patientData});

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
  void initState() {
    super.initState();
    _emailController.text = widget.patientData['email'];
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
                  Text(
                    'Create Patient Profile',
                    style: Theme.of(context).brightness == Brightness.dark
                        ? Theme.of(context).textTheme.bodyLarge
                        : Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: Theme.of(context).primaryColor,
                            ),
                  ),
                  const SizedBox(
                    height: 40.0,
                  ),
                  CustomTextFormField(
                    controller: _nameController,
                    validator: PatientFormValidator.validateName,
                    labelText: 'Patient Name',
                    hintText: 'Enter Patient Name',
                    suffixIcon: Icons.person,
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  CustomTextFormField(
                    controller: _emailController,
                    validator: PatientFormValidator.validateEmail,
                    keyboardType: TextInputType.emailAddress,
                    labelText: 'Patient Email',
                    hintText: 'Enter Patient Email',
                    suffixIcon: Icons.email,
                    enabled: false,
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextFormField(
                          controller: _weightController,
                          validator: PatientFormValidator.validateWeight,
                          keyboardType: TextInputType.number,
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
                          keyboardType: TextInputType.number,
                          labelText: 'Height',
                          hintText: '20-110 (inches)',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30.0,
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
                    height: 30.0,
                  ),
                  DatePickerField(
                    controller: _dobController,
                    labelText: 'Date of Birth',
                    hintText: 'Select Date of Birth',
                    validator: PatientFormValidator.validateDob,
                  ),
                  const SizedBox(
                    height: 40.0,
                  ),
                  CustomElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PatientHistory(
                              patientData: {
                                'id': widget.patientData['id'],
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
      ),
    );
  }
}
