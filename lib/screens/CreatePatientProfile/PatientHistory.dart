import 'package:flutter/material.dart';
import 'package:sehatyaab/validations/ProfileFormValidator.dart';
import 'package:sehatyaab/widgets/ElevatedButton.dart';
import 'package:sehatyaab/widgets/FormContainer.dart';
import 'package:sehatyaab/widgets/TextFormField.dart';
import '../../models/Patient.dart';
import '../../services/FirestoreService.dart';
import '../../theme/AppColors.dart';
import '../../widgets/CustomAppBar.dart';
import '../Login/LoginScreen.dart';

class PatientHistory extends StatefulWidget {
  final Map<String, dynamic> patientData;
  const PatientHistory({super.key, required this.patientData});

  @override
  _PatientHistoryState createState() => _PatientHistoryState();
}

class _PatientHistoryState extends State<PatientHistory> {
  final _formKey = GlobalKey<FormState>();
  bool _isBpPatient = false;
  bool _isSugarPatient = false;
  bool _hasMedicalHistory = false;
  bool _hasFamilyHistory = false;
  bool _hasOngoingMedications = false;

  final TextEditingController _medicalHistoryTypeController =
      TextEditingController();
  final TextEditingController _medicalHistoryDescController =
      TextEditingController();
  final TextEditingController _medicalHistoryYearController =
      TextEditingController();

  final TextEditingController _familyHistoryTypeController =
      TextEditingController();
  final TextEditingController _familyHistoryDescController =
      TextEditingController();

  final TextEditingController _ongoingMedicationsController =
      TextEditingController();
  final FirestoreService<Patient> _firestoreService =
      FirestoreService<Patient>('patients');

  void _savePatientData() {
    if (_formKey.currentState!.validate()) {
      double? weight = double.tryParse(widget.patientData['weight'] ?? '');
      double? height = double.tryParse(widget.patientData['height'] ?? '');

      if (weight == null || height == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Invalid weight or height',
                  style: Theme.of(context).textTheme.bodySmall),
              backgroundColor: AppColors.blue2),
        );
        return;
      }

      Patient patient = Patient(
        id: widget.patientData['id'],
        name: widget.patientData['name'],
        email: widget.patientData['email'],
        gender: widget.patientData['gender'],
        dob: widget.patientData['dob'],
        isBpPatient: _isBpPatient,
        isSugarPatient: _isSugarPatient,
        medicalHistoryType:
            _hasMedicalHistory ? _medicalHistoryTypeController.text : null,
        medicalHistoryDesc:
            _hasMedicalHistory ? _medicalHistoryDescController.text : null,
        medicalHistoryYear: _hasMedicalHistory
            ? int.tryParse(_medicalHistoryYearController.text)
            : 0,
        familyHistoryType:
            _hasFamilyHistory ? _familyHistoryTypeController.text : null,
        familyHistoryDesc:
            _hasFamilyHistory ? _familyHistoryDescController.text : null,
        ongoingMedications:
            _hasOngoingMedications ? _ongoingMedicationsController.text : null,
        weight: weight,
        height: height,
      );

      _firestoreService.addItemWithId(patient, patient.id).then((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Profile Created Successfully',
                  style: Theme.of(context).textTheme.bodySmall),
              backgroundColor: AppColors.blue2),
        );
        Navigator.of(context).pop();

        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const LoginScreen()));
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Failed to Create Profile: $error',
                  style: Theme.of(context).textTheme.bodySmall),
              backgroundColor: AppColors.blue2),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        profile: true,
      ),
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
                    'Patient History',
                    style: Theme.of(context).brightness == Brightness.dark
                        ? Theme.of(context).textTheme.bodyLarge
                        : Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(color: Theme.of(context).primaryColor),
                  ),
                  const SizedBox(height: 30),
                  SwitchListTile(
                    title: Text(
                      'Do you have Blood Pressure?',
                      style: Theme.of(context).brightness == Brightness.dark
                          ? Theme.of(context).textTheme.bodyMedium
                          : Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: Theme.of(context).primaryColor),
                    ),
                    value: _isBpPatient,
                    onChanged: (bool value) {
                      setState(() {
                        _isBpPatient = value;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  SwitchListTile(
                    title: Text(
                      'Do you have Sugar?',
                      style: Theme.of(context).brightness == Brightness.dark
                          ? Theme.of(context).textTheme.bodyMedium
                          : Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: Theme.of(context).primaryColor),
                    ),
                    value: _isSugarPatient,
                    onChanged: (bool value) {
                      setState(() {
                        _isSugarPatient = value;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  SwitchListTile(
                    title: Text(
                      'Any Medical Histories?',
                      style: Theme.of(context).brightness == Brightness.dark
                          ? Theme.of(context).textTheme.bodyMedium
                          : Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: Theme.of(context).primaryColor),
                    ),
                    value: _hasMedicalHistory,
                    onChanged: (bool value) {
                      setState(() {
                        _hasMedicalHistory = value;
                      });
                    },
                  ),
                  const SizedBox(height: 17),
                  if (_hasMedicalHistory)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 17.0),
                      child: Column(
                        children: [
                          CustomTextFormField(
                            controller: _medicalHistoryTypeController,
                            validator: (value) =>
                                ProfileFormValidator.validateMedicalHistoryType(
                                    value, _hasMedicalHistory),
                            labelText: "Type",
                            hintText: "Fracture",
                          ),
                          const SizedBox(height: 17.0),
                          CustomTextFormField(
                            controller: _medicalHistoryYearController,
                            keyboardType: TextInputType.number,
                            validator: (value) =>
                                ProfileFormValidator.validateMedicalHistoryYear(
                                    value, _hasMedicalHistory),
                            labelText: "Year",
                            hintText: "2023",
                          ),
                          const SizedBox(height: 17.0),
                          CustomTextFormField(
                            controller: _medicalHistoryDescController,
                            validator: (value) =>
                                ProfileFormValidator.validateMedicalHistoryDesc(
                                    value, _hasMedicalHistory),
                            labelText: "Description",
                            hintText:
                                "Medicines/ Duration for Recovery/ Any Severe Impacts?",
                            maxLines: 3,
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                  const SizedBox(height: 10),
                  SwitchListTile(
                    title: Text(
                      'Do you have any Family Medical History?',
                      style: Theme.of(context).brightness == Brightness.dark
                          ? Theme.of(context).textTheme.bodyMedium
                          : Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: Theme.of(context).primaryColor),
                    ),
                    value: _hasFamilyHistory,
                    onChanged: (bool value) {
                      setState(() {
                        _hasFamilyHistory = value;
                      });
                    },
                  ),
                  const SizedBox(height: 17),
                  if (_hasFamilyHistory)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 17.0),
                      child: Column(
                        children: [
                          CustomTextFormField(
                            controller: _familyHistoryTypeController,
                            validator: (value) =>
                                ProfileFormValidator.validateFamilyHistoryType(
                                    value, _hasFamilyHistory),
                            labelText: "Type",
                            hintText: "Heart Disease",
                          ),
                          const SizedBox(height: 17.0),
                          CustomTextFormField(
                            controller: _familyHistoryDescController,
                            validator: (value) =>
                                ProfileFormValidator.validateFamilyHistoryDesc(
                                    value, _hasFamilyHistory),
                            labelText: "Description",
                            hintText: "Details about family medical history",
                            maxLines: 3,
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                  const SizedBox(height: 10),
                  SwitchListTile(
                    title: Text(
                      'Are you on any Ongoing Medications?',
                      style: Theme.of(context).brightness == Brightness.dark
                          ? Theme.of(context).textTheme.bodyMedium
                          : Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: Theme.of(context).primaryColor),
                    ),
                    value: _hasOngoingMedications,
                    onChanged: (bool value) {
                      setState(() {
                        _hasOngoingMedications = value;
                      });
                    },
                  ),
                  const SizedBox(height: 17),
                  if (_hasOngoingMedications)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 17.0),
                      child: Column(
                        children: [
                          CustomTextFormField(
                            controller: _ongoingMedicationsController,
                            validator: (value) =>
                                ProfileFormValidator.validateOngoingMedications(
                                    value, _hasOngoingMedications),
                            labelText: "Ongoing Medications",
                            hintText:
                                "Enter Medicines in Comma Separated Format. (e.g. Panadol, Zeegap)",
                            maxLines: 3,
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: CustomElevatedButton(
                      onPressed: _savePatientData,
                      label: 'Submit',
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
