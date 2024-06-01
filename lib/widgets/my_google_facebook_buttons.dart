import 'package:flutter/material.dart';

class MyImageButton extends StatelessWidget {
  final String imagePath;
  final Function()? onTap;
  const MyImageButton({
    super.key,
    required this.imagePath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color.fromRGBO(222, 222, 222, 1.0),
          ),
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
        ),
        child: Image.asset(
          imagePath,
          height: 50,
          width: 50,
        ),
      ),
    );
  }
}

class MyGoogleFacebookButtons extends StatelessWidget {
  final Function()? onGoogleTap;
  final Function()? onFacebookTap;

  const MyGoogleFacebookButtons({
    super.key,
    required this.onGoogleTap,
    required this.onFacebookTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MyImageButton(
          imagePath: 'assets/images/google.png',
          onTap: onGoogleTap,
        ),
        const SizedBox(
          width: 20,
        ),
        MyImageButton(
          imagePath: 'assets/images/facebook.png',
          onTap: onFacebookTap,
        ),
      ],
    );
  }
}
