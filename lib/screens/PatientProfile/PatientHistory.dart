import 'package:flutter/material.dart';
import 'package:sehatyaab/validations/PatientFormValidator.dart';
import 'package:sehatyaab/widgets/ElevatedButton.dart';
import 'package:sehatyaab/widgets/MainContainer.dart';
import 'package:sehatyaab/widgets/TextFormField.dart';
import '../../models/patient.dart';
import '../../services/FirestoreService.dart';

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

  void _savePatientData() {
    if (_formKey.currentState!.validate()) {
      double? weight = double.tryParse(widget.patientData['weight'] ?? '');
      double? height = double.tryParse(widget.patientData['height'] ?? '');

      if (weight == null || height == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid weight or height')),
        );
        return;
      }

      Patient patient = Patient(
        id: "",
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

      FirestoreService('patients').addItem(patient).then((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Information saved successfully')),
        );
        Navigator.pop(context); 
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save information: $error')),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return SingleChildScrollView(
      child: MainContainer(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Text(
                'Patient History',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              SizedBox(height: 20),
              SwitchListTile(
                title: Text(
                  'Do you have Blood Pressure?',
                  style: theme.textTheme.bodyMedium,
                ),
                value: _isBpPatient,
                onChanged: (bool value) {
                  setState(() {
                    _isBpPatient = value;
                  });
                },
              ),
              SizedBox(height: 20),
              SwitchListTile(
                title: Text(
                  'Do you have Sugar?',
                  style: theme.textTheme.bodyMedium,
                ),
                value: _isSugarPatient,
                onChanged: (bool value) {
                  setState(() {
                    _isSugarPatient = value;
                  });
                },
              ),
              SizedBox(height: 20),
              SwitchListTile(
                title: Text(
                  'Any Medical Histories?',
                  style: theme.textTheme.bodyMedium,
                ),
                value: _hasMedicalHistory,
                onChanged: (bool value) {
                  setState(() {
                    _hasMedicalHistory = value;
                  });
                },
              ),
              if (_hasMedicalHistory)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 17.0),
                  child: Column(
                    children: [
                      CustomTextFormField(
                        controller: _medicalHistoryTypeController,
                        validator: (value) =>
                            PatientFormValidator.validateMedicalHistoryType(
                                value, _hasMedicalHistory),
                        labelText: "Type",
                        hintText: "Fracture",
                      ),
                      SizedBox(height: 24.0),
                      CustomTextFormField(
                        controller: _medicalHistoryYearController,
                        keyboardType: TextInputType.number,
                        validator: (value) =>
                            PatientFormValidator.validateMedicalHistoryYear(
                                value, _hasMedicalHistory),
                        labelText: "Year",
                        hintText: "2023",
                      ),
                      SizedBox(height: 24.0),
                      CustomTextFormField(
                        controller: _medicalHistoryDescController,
                        validator: (value) =>
                            PatientFormValidator.validateMedicalHistoryDesc(
                                value, _hasMedicalHistory),
                        labelText: "Description",
                        hintText:
                            "Medicines/ Duration for Recovery/ Any Severe Impacts?",
                        maxLines: 3,
                      ),
                    ],
                  ),
                ),
              SizedBox(height: 20),
              SwitchListTile(
                title: Text(
                  'Do you have any Family Medical History?',
                  style: theme.textTheme.bodyMedium,
                ),
                value: _hasFamilyHistory,
                onChanged: (bool value) {
                  setState(() {
                    _hasFamilyHistory = value;
                  });
                },
              ),
              if (_hasFamilyHistory)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 17.0),
                  child: Column(
                    children: [
                      CustomTextFormField(
                        controller: _familyHistoryTypeController,
                        validator: (value) =>
                            PatientFormValidator.validateFamilyHistoryType(
                                value, _hasFamilyHistory),
                        labelText: "Type",
                        hintText: "Heart Disease",
                      ),
                      SizedBox(height: 24.0),
                      CustomTextFormField(
                        controller: _familyHistoryDescController,
                        validator: (value) =>
                            PatientFormValidator.validateFamilyHistoryDesc(
                                value, _hasFamilyHistory),
                        labelText: "Description",
                        hintText: "Details about family medical history",
                        maxLines: 3,
                      ),
                    ],
                  ),
                ),
              SizedBox(height: 20),
              SwitchListTile(
                title: Text(
                  'Are you on any Ongoing Medications?',
                  style: theme.textTheme.bodyMedium,
                ),
                value: _hasOngoingMedications,
                onChanged: (bool value) {
                  setState(() {
                    _hasOngoingMedications = value;
                  });
                },
              ),
              if (_hasOngoingMedications)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 17.0),
                  child: Column(
                    children: [
                      CustomTextFormField(
                        controller: _ongoingMedicationsController,
                        validator: (value) =>
                            PatientFormValidator.validateOngoingMedications(
                                value, _hasOngoingMedications),
                        labelText: "Ongoing Medications",
                        hintText: "List ongoing medications",
                        maxLines: 3,
                      ),
                    ],
                  ),
                ),
              SizedBox(height: 40),
              CustomElevatedButton(
                onPressed: _savePatientData,
                label: 'Save',
              )
            ],
          ),
        ),
      ),
    );
  }
}
