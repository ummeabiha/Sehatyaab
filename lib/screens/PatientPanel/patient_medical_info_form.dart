import 'package:flutter/material.dart';
import '../../models/patient.dart';
import '../../services/firestore_service.dart';

class PatientMedicalInfoForm extends StatefulWidget {
  final Map<String, dynamic> patientData;

  const PatientMedicalInfoForm({super.key, required this.patientData});

  @override
  _PatientMedicalInfoFormState createState() => _PatientMedicalInfoFormState();
}


class _PatientMedicalInfoFormState extends State<PatientMedicalInfoForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isBpPatient = false;
  bool _isSugarPatient = false;
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
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
  bool _hasMedicalHistory = false;
  bool _hasFamilyHistory = false;
  bool _hasOngoingMedications = false;

  void _savePatientData() {
    if (_formKey.currentState!.validate()) {
      Patient patient = Patient(
        name: widget.patientData['name'],
        email: widget.patientData['email'],
        age: widget.patientData['age'],
        gender: widget.patientData['gender'],
        dob: widget.patientData['dob'],
        isBpPatient: _isBpPatient,
        isSugarPatient: _isSugarPatient,
        height: double.parse(_heightController.text),
        weight: double.parse(_weightController.text),
        medicalHistoryType:
            _hasMedicalHistory ? _medicalHistoryTypeController.text : null,
        medicalHistoryDesc:
            _hasMedicalHistory ? _medicalHistoryDescController.text : null,
        medicalHistoryYear: _hasMedicalHistory
            ? int.tryParse(_medicalHistoryYearController.text)
            : null,
        familyHistoryType:
            _hasFamilyHistory ? _familyHistoryTypeController.text : null,
        familyHistoryDesc:
            _hasFamilyHistory ? _familyHistoryDescController.text : null,
        ongoingMedications:
            _hasOngoingMedications ? _ongoingMedicationsController.text : null,
      );

      FirestoreService('patients').addItem(patient).then((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Information saved successfully')),
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
      appBar: AppBar(
        title: const Text('Patient Medical Information'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              SwitchListTile(
                title: const Text('Are you a BP patient?'),
                value: _isBpPatient,
                onChanged: (bool value) {
                  setState(() {
                    _isBpPatient = value;
                  });
                },
              ),
              SwitchListTile(
                title: const Text('Are you a Sugar patient?'),
                value: _isSugarPatient,
                onChanged: (bool value) {
                  setState(() {
                    _isSugarPatient = value;
                  });
                },
              ),
              TextFormField(
                controller: _heightController,
                decoration: const InputDecoration(labelText: 'Height (cm)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter height';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid height';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _weightController,
                decoration: const InputDecoration(labelText: 'Weight (kg)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter weight';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid weight';
                  }
                  return null;
                },
              ),
              SwitchListTile(
                title: const Text('Do you have any medical history?'),
                value: _hasMedicalHistory,
                onChanged: (bool value) {
                  setState(() {
                    _hasMedicalHistory = value;
                  });
                },
              ),
              if (_hasMedicalHistory)
                Column(
                  children: [
                    TextFormField(
                      controller: _medicalHistoryTypeController,
                      decoration: const InputDecoration(
                          labelText: 'Medical History Type'),
                    ),
                    TextFormField(
                      controller: _medicalHistoryDescController,
                      decoration: const InputDecoration(
                          labelText: 'Medical History Description'),
                    ),
                    TextFormField(
                      controller: _medicalHistoryYearController,
                      decoration: const InputDecoration(
                          labelText: 'Medical History Year'),
                      keyboardType: TextInputType.number,
                    ),
                  ],
                ),
              SwitchListTile(
                title: const Text('Do you have any family medical history?'),
                value: _hasFamilyHistory,
                onChanged: (bool value) {
                  setState(() {
                    _hasFamilyHistory = value;
                  });
                },
              ),
              if (_hasFamilyHistory)
                Column(
                  children: [
                    TextFormField(
                      controller: _familyHistoryTypeController,
                      decoration: const InputDecoration(
                          labelText: 'Family History Type'),
                    ),
                    TextFormField(
                      controller: _familyHistoryDescController,
                      decoration: const InputDecoration(
                          labelText: 'Family History Description'),
                    ),
                  ],
                ),
              SwitchListTile(
                title: const Text('Are you on any ongoing medications?'),
                value: _hasOngoingMedications,
                onChanged: (bool value) {
                  setState(() {
                    _hasOngoingMedications = value;
                  });
                },
              ),
              if (_hasOngoingMedications)
                TextFormField(
                  controller: _ongoingMedicationsController,
                  decoration:
                      const InputDecoration(labelText: 'Ongoing Medications'),
                ),
              ElevatedButton(
                onPressed: _savePatientData,
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
