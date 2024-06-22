import 'package:flutter/material.dart';
import '../../theme/AppColors.dart';
import '../../widgets/FormContainer.dart';
import 'LoginForm.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? AppColors.black2
            : Theme.of(context).cardColor,
        body: Center(
            child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(top: 40.0, bottom: 16.0),
            child: FormContainer(
              child: Form(
                child: Column(
                  children: [
                    SizedBox(
                      width: 280.0,
                      child: Image.asset('assets/images/login.png'),
                    ),
                    const SizedBox(height: 10),
                    Text("Welcome Back",
                        style: Theme.of(context).brightness == Brightness.dark
                            ? Theme.of(context).textTheme.bodyLarge
                            : Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  color: Theme.of(context).primaryColor,
                                )),
                    const SizedBox(height: 10),
                    Text("Login To Your Account",
                        style: Theme.of(context).brightness == Brightness.dark
                            ? Theme.of(context).textTheme.bodyMedium
                            : Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: Theme.of(context).primaryColor,
                                )),
                    const SizedBox(height: 35),
                    const LoginForm(),
                  ],
                ),
              ),
            ),
          ),
        )));
  }
}
