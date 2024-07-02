import 'package:flutter/material.dart';
import '../../theme/AppColors.dart';

class ProfileStackWidget extends StatelessWidget {
  final String name;
  final String email;
  final String gender;
  final bool? isDoctor;

  const ProfileStackWidget({
    super.key,
    required this.name,
    required this.email,
    required this.gender,
    this.isDoctor,
  });

  @override
  Widget build(BuildContext context) {
    String avatarImagePath;

    if (isDoctor ?? false) {
      avatarImagePath = gender.toLowerCase() == 'male'
          ? 'assets/images/male.png'
          : 'assets/images/female.png';
    } else {
      avatarImagePath = gender.toLowerCase() == 'male'
          ? 'assets/images/DoctorPanel/boy.png'
          : 'assets/images/DoctorPanel/girl.png';
    }

    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.32,
          color: Theme.of(context).cardColor,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 24.0),
        ),
        Positioned(
          top: 40.0,
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Theme.of(context).hoverColor,
                    width: 3.0,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).primaryColor,
                      spreadRadius: 2,
                      blurRadius: 2,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: AppColors.blue1,
                  backgroundImage: AssetImage(avatarImagePath),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                name,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: Theme.of(context).primaryColor),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                email,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: Theme.of(context).primaryColor),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
