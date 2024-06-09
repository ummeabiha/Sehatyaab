import 'package:flutter/material.dart';

import '../../components/background.dart';
import 'components/signup_form.dart';
import '../../../constants.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Background(
      child: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                children: [
                  Text("Register", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: kPrimaryColor,), textAlign: TextAlign.center,),
                  Text("Create your account", style: TextStyle(fontSize: 15, color: navyBlue,),),
                  const SizedBox(height: defaultPadding),
                  const SizedBox(height: defaultPadding),
                ],
              ),
              Row(
                children: [
                  Spacer(),
                  Expanded(
                    flex: 8,
                    child: SignUpForm(),
                  ),
                  Spacer(),
                ],
              ),
              // SocalSignUp() // Uncomment this line if you want to include SocalSignUp
            ],
          ),
        ),
      ),
    );
  }
}
