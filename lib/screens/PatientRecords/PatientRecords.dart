import 'package:flutter/material.dart';
import 'package:sehatyaab/models/Appointments.dart';
import '../../validations/RecordFormValidator.dart';
import '../../widgets/CustomAppBar.dart';
import '../../widgets/CustomStyledTextField.dart';
import '../../widgets/ElevatedButton.dart';
import '../../widgets/FormContainer.dart';
import '../DisplayAppointments/DoctorPanelHeader.dart';
import '../VideoCall/VideoCall.dart';
import '../../services/FirestoreService.dart'; 

class PatientRecords extends StatelessWidget {
  final String userID;
  final String userName;
  final String? appointmentID;
  final _formKey = GlobalKey<FormState>();
  final _diagnosisController = TextEditingController();
  final _prescribedMedsController = TextEditingController();
  final _prescribedTestsController = TextEditingController();

  PatientRecords(
      {super.key,
      required this.userID,
      required this.userName,
      this.appointmentID});

  final FirestoreService<Appointment> _firestoreService =
      FirestoreService<Appointment>('appointments');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const DoctorPanelHeader(
                imagePath: 'assets/images/DoctorPanel/record.png',
                text: 'Patient Records',
              ),
              CustomElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => VideoCall(
                        userID: userID,
                        userName: userName,
                        appointmentID: appointmentID,
                      ),
                    ),
                  );
                },
                label: 'Rejoin Call',
                removeUpperBorders: true,
                blueColor: true,
              ),
              FormContainer(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomStyledTextField(
                        controller: _diagnosisController,
                        validator: RecordFormValidator.validateDiagnosis,
                        labelText: 'Diagnosis',
                        hintText: 'Comma Separated (Cold, Fever)',
                        suffixIcon: Icons.troubleshoot_sharp,
                      ),
                      const SizedBox(height: 25.0),
                      CustomStyledTextField(
                        controller: _prescribedMedsController,
                        validator: RecordFormValidator.validateMeds,
                        labelText: 'Prescribe Medicines',
                        hintText: 'Comma Separated (Panadol, Zeegap)',
                        suffixIcon: Icons.medication,
                      ),
                      const SizedBox(height: 25.0),
                      CustomStyledTextField(
                        controller: _prescribedTestsController,
                        labelText: 'Prescribed Tests',
                        hintText: 'Comma Separated (CBC, Pneumonia)',
                        suffixIcon: Icons.science,
                      ),
                      const SizedBox(height: 30.0),
                      CustomElevatedButton(
                        blueColor: true,
                        onPressed: () async {
                          if (_formKey.currentState?.validate() ?? false) {
                            final diagnosis = _diagnosisController.text;
                            final prescribedMeds =
                                _prescribedMedsController.text;
                            final prescribedTests =
                                _prescribedTestsController.text;

                            if (appointmentID != null) {
                              final updateData = {
                                'status': false,
                                'diagnosis': diagnosis,
                                'prescribedMeds': prescribedMeds,
                                'prescribedTests': prescribedTests,
                              };

                              await _firestoreService.updateItem(
                                  appointmentID!, updateData);

                              Navigator.pop(context);
                            } else {
                              debugPrint('Error: appointmentID is null');
                            }
                          }
                        },
                        label: 'Submit Record',
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
