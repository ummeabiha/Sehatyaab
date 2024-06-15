import 'package:flutter/material.dart';
import 'components/login_form.dart';
import '../../../constants.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            LoginScreenTopImage(),
            Row(
              children: [
                Spacer(),
                Expanded(
                  flex: 8,
                  child: LoginForm(),
                ),
                Spacer(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class LoginScreenTopImage extends StatelessWidget {
  const LoginScreenTopImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Welcome Back",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: kPrimaryColor,
          ),
          textAlign: TextAlign.center,
        ),
        const Text(
          "Login to your account",
          style: TextStyle(
            fontSize: 15,
            color: navyBlue,
          ),
        ),
        const SizedBox(height: defaultPadding * 2),
        Row(
          children: [
            const Spacer(),
            Expanded(
              flex: 8,
              child: Image.asset("assets/images/login.png"),
            ),
            const Spacer(),
          ],
        ),
        const SizedBox(height: defaultPadding * 2),
      ],
    );
  }
}
