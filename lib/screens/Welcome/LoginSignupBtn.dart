import 'package:flutter/material.dart';
import '../../routes/AppRoutes.dart';
import '../../widgets/ElevatedButton.dart';

class LoginAndSignupBtn extends StatelessWidget {
  const LoginAndSignupBtn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, AppRoutes.login);
          },
          label: "Login",
        ),
        const SizedBox(height: 25),
        CustomElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, AppRoutes.signup);
          },
          label: "Register",
        ),
      ],
    );
  }
}
