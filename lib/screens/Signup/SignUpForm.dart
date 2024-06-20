import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sehatyaab/screens/home_screen.dart';
import '../../components/already_have_an_account_acheck.dart';
import '../../constants.dart';
import '../Login/LoginScreen.dart';
import '../../services/FirestoreService.dart';
import '../../models/UserAccounts.dart';
import '../../models/doctor.dart';
import '../../models/patient.dart';

class SignUpForm extends StatefulWidget {const SignUpForm({Key? key}) : super(key: key);
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _selectedOption;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirestoreService<UserAccounts> _firestoreService = FirestoreService<UserAccounts>('users');


  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your name';
    }
    return null;
  }

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
        UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );
        UserAccounts user = UserAccounts(
          id: userCredential.user!.uid,
          email: _emailController.text,
          password: _passwordController.text,
          option: _selectedOption,
          name: "",
        );
        await _firestoreService.addItemWithId(user, user.id);

        if (_selectedOption == 'Doctor') {
          Doctor doctor = Doctor(
            id: userCredential.user!.uid,
            name: _nameController.text,
            email: _emailController.text,
            gender: "",
            dob: "",
            specialization: "",
            qualification: "",
            yearsOfExperience: 0,
          );

          FirestoreService<Doctor> firestoreService = FirestoreService<Doctor>('doctors');
          await firestoreService.addItemWithId(doctor, doctor.id);
        } else {
          Patient patient = Patient(
            id: userCredential.user!.uid,
            name: _nameController.text,
            email: _emailController.text,
            gender: "",
            dob: "",
            height: 0,
            weight: 0,
          );

          FirestoreService<Patient> firestoreService = FirestoreService<Patient>('patients');
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
          TextFormField(
            controller: _nameController,
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
            cursorColor: kPrimaryColor,
            validator: _validateName,
            decoration: const InputDecoration(
              hintText: "Your name",
              prefixIcon: Padding(
                padding: EdgeInsets.all(defaultPadding),
                child: Icon(Icons.person),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              cursorColor: kPrimaryColor,
              validator: _validateEmail,
              decoration: const InputDecoration(
                hintText: "Your email",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.email),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: DropdownButtonFormField<String>(
              value: _selectedOption,
              hint: const Text("Select the option"),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedOption = newValue;
                });
              },
              validator: _validateOption,
              items: <String>['Doctor', 'Patient']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              decoration: const InputDecoration(
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.arrow_drop_down),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              controller: _passwordController,
              textInputAction: TextInputAction.done,
              obscureText: true,
              cursorColor: kPrimaryColor,
              validator: _validatePassword,
              decoration: const InputDecoration(
                hintText: "Your password",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.lock),
                ),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding / 2),
          ElevatedButton(
            onPressed: _signUp,
            child: Text("Sign Up".toUpperCase()),
          ),
          const SizedBox(height: defaultPadding),
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
