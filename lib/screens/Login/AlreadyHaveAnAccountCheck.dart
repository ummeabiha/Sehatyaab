import 'package:flutter/material.dart';

class AlreadyHaveAnAccountCheck extends StatelessWidget {
  final bool login;
  final Function? press;
  const AlreadyHaveAnAccountCheck({
    super.key,
    this.login = true,
    required this.press,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          login ? "Do not have an Account? " : "Already have an Account? ",
          style: Theme.of(context).brightness == Brightness.dark
                          ? Theme.of(context).textTheme.bodySmall
                          : Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: Theme.of(context).primaryColor,
                              )),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: press as void Function()?,
          child: Text(
            login ? "Sign Up" : "Sign In",
            style: Theme.of(context).brightness == Brightness.dark
                          ? Theme.of(context).textTheme.bodyMedium
                          : Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: Theme.of(context).primaryColor,
                              ))
        )
      ],
    );
  }
}
