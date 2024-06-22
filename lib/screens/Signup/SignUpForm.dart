import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../widgets/DropDown.dart';
import '../../widgets/ElevatedButton.dart';
import '../../widgets/TextFormField.dart';
import '../Login/AlreadyHaveAnAccountCheck.dart';
import '../Login/LoginScreen.dart';
import '../../services/FirestoreService.dart';
import '../../models/UserAccounts.dart';
import '../../models/doctor.dart';
import '../../models/patient.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _selectedOption;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirestoreService<UserAccounts> _firestoreService =
      FirestoreService<UserAccounts>('users');

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    String pattern = r'^[^@]+@[^@]+\.[^@]+';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Enter a valid email';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  String? _validateOption(String? value) {
    if (value == null) {
      return 'Please select an option';
    }
    return null;
  }

  Future<void> _signUp() async {
    if (_formKey.currentState!.validate()) {
      try {
        UserCredential userCredential =
            await _auth.createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );
        UserAccounts user = UserAccounts(
          id: userCredential.user!.uid,
          email: _emailController.text,
          password: _passwordController.text,
          option: _selectedOption,
        );
        await _firestoreService.addItemWithId(user, user.id);

        if (_selectedOption == 'Doctor') {
          Doctor doctor = Doctor(
            id: userCredential.user!.uid,
            name: '',
            email: _emailController.text,
            gender: "",
            dob: "",
            specialization: "",
            qualification: "",
            yearsOfExperience: 0,
          );

          FirestoreService<Doctor> firestoreService =
              FirestoreService<Doctor>('doctors');
          await firestoreService.addItemWithId(doctor, doctor.id);
        } else {
          Patient patient = Patient(
            id: userCredential.user!.uid,
            name: '',
            email: _emailController.text,
            gender: "",
            dob: "",
            height: 0,
            weight: 0,
          );

          FirestoreService<Patient> firestoreService =
              FirestoreService<Patient>('patients');
          await firestoreService.addItemWithId(patient, patient.id);
        }

        print('User signed up: ${userCredential.user!.uid}');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message ?? 'Sign up failed')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomTextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            validator: _validateEmail,
            labelText: 'Email Address',
            hintText: 'xyz@gmail.com',
            suffixIcon: Icons.email,
          ),
          const SizedBox(height: 30),
          CustomTextFormField(
            controller: _passwordController,
            validator: _validatePassword,
            obscureText: true,
            labelText: 'Password',
            hintText: 'Enter Password',
            suffixIcon: Icons.lock,
          ),
          const SizedBox(height: 30),
          CustomDropdown<String>(
            value: _selectedOption,
            decoration: InputDecoration(
              labelText: 'User Role',
              labelStyle: Theme.of(context).textTheme.bodySmall,
            ),
            items: <String>['Doctor', 'Patient']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                _selectedOption = newValue;
              });
            },
            validator: _validateOption,
          ),
          const SizedBox(
            height: 35.0,
          ),
          CustomElevatedButton(
            onPressed: _signUp,
            label: 'Register',
          ),
          const SizedBox(height: 30),
          AlreadyHaveAnAccountCheck(
            login: false,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const LoginScreen();
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
