import 'package:flutter/material.dart';
import '../../theme/AppColors.dart';
import '../../widgets/FormContainer.dart';
import 'SignUpForm.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? AppColors.black2
            : Theme.of(context).cardColor,
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(top: 28.0),
            child: FormContainer(
              child: Form(
                child: Column(
                  children: [
                    SizedBox(
                      width: 260.0,
                      child: Image.asset('assets/images/login.png'),
                    ),
                    const SizedBox(height: 12),
                    Text("Register",
                        style: Theme.of(context).brightness == Brightness.dark
                            ? Theme.of(context).textTheme.bodyLarge
                            : Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  color: Theme.of(context).primaryColor,
                                )),
                    const SizedBox(height: 5),
                    Text("Create Your Account",
                        style: Theme.of(context).brightness == Brightness.dark
                            ? Theme.of(context).textTheme.bodyMedium
                            : Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: Theme.of(context).primaryColor,
                                )),
                    const SizedBox(height: 26),
                    const SignUpForm(),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
