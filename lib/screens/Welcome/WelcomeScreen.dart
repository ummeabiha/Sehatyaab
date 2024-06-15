import 'package:flutter/material.dart';
import 'LoginSignupBtn.dart';
import '../../../constants.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            WelcomeImage(),
            Row(
              children: [
                Spacer(),
                Expanded(
                  flex: 6,
                  child: LoginAndSignupBtn(),
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

class WelcomeImage extends StatelessWidget {
  const WelcomeImage({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Sehatyaab",
          style: TextStyle(
              fontSize: 30, fontWeight: FontWeight.bold, color: kPrimaryColor),
          textAlign: TextAlign.center,
        ),
        const Text(
          "Bridging the gap in medical facilities",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w100, color: navyBlue),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: defaultPadding * 2),
        Row(
          children: [
            const Spacer(),
            Expanded(
              flex: 8,
              child: Image.asset(
                "assets/images/sehatyaab-logo.png",
                width: 400.0,
                height: 400.0,
              ),
            ),
            const Spacer(),
          ],
        ),
        const SizedBox(height: defaultPadding * 2),
      ],
    );
  }
}
