import 'package:flutter/material.dart';

class TopImage extends StatelessWidget {
  const TopImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/bg.png'),
              fit: BoxFit.contain,
            ),
          ),
          height: MediaQuery.of(context).size.height * 0.23,
        ),
        Positioned(
          left: 0,
          right: 0,
          child: Container(
            height: 150.0,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/top_image.png'),
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
