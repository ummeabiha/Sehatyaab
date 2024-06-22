import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sehatyaab/routes/AppRoutes.dart';
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

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth.signInWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );
        Navigator.pushReplacementNamed(context, AppRoutes.patienthp);
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message ?? 'Login failed')),
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
          
          const SizedBox(height: 35),

          CustomElevatedButton(
            onPressed: _login,
            label: 'Login',
          ),

          const SizedBox(height: 30),

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
