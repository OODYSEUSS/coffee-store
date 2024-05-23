import 'package:flutter/material.dart';

class MyProfileImageButton extends StatelessWidget {
  const MyProfileImageButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          image: const DecorationImage(
            image: AssetImage('assets/images/user_photo.png'),
          ),
        ),
      ),
    );
  }
}
