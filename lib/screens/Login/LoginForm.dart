import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sehatyaab/models/UserAccounts.dart';
import 'package:sehatyaab/routes/AppRoutes.dart';
import '../../globals.dart';
import '../../services/FirestoreService.dart';
import '../../theme/AppColors.dart';
import '../../validations/AuthFormValidator.dart';
import '../../widgets/ElevatedButton.dart';
import '../../widgets/TextFormField.dart';
import '../Signup/SignUpScreen.dart';
import 'AlreadyHaveAnAccountCheck.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      try {
        final UserCredential userCredential =
            await _auth.signInWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );

        final String userId = userCredential.user!.uid;
        final FirestoreService<UserAccounts> firestoreService =
            FirestoreService<UserAccounts>('users');

        final UserAccounts? user = await firestoreService.getItemById(
            userId, UserAccounts(id: '', password: '', email: '', option: ''));

        if (user != null) {
          if (user.option == 'Doctor') {
            globalDoctorId = userId;
            globalDoctorEmail = user.email;
            Navigator.pushReplacementNamed(context, AppRoutes.displayPatient);
          } else {
            globalPatientId = userId;
            globalPatientEmail = user.email;
            Navigator.pushReplacementNamed(context, AppRoutes.patienthp);
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text('User Not Found',
                    style: Theme.of(context).textTheme.bodySmall),
                backgroundColor: AppColors.blue2),
          );
        }
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Login failed: ${e.message ?? "Unknown Error"}',
                  style: Theme.of(context).textTheme.bodySmall),
              backgroundColor: AppColors.blue2),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('An error occurred: $e',
                  style: Theme.of(context).textTheme.bodySmall),
              backgroundColor: AppColors.blue2),
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
            validator: AuthFormValidator.validateEmail,
            labelText: 'Email Address',
            hintText: 'xyz@gmail.com',
            suffixIcon: Icons.email,
          ),
          const SizedBox(height: 20),
          CustomTextFormField(
            controller: _passwordController,
            validator: AuthFormValidator.validatePassword,
            obscureText: true,
            labelText: 'Password',
            hintText: 'Enter Password',
            suffixIcon: Icons.lock,
          ),
          const SizedBox(height: 25),
          CustomElevatedButton(
            onPressed: _login,
            label: 'Login',
          ),
          const SizedBox(height: 25),
          AlreadyHaveAnAccountCheck(
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const SignUpScreen();
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
