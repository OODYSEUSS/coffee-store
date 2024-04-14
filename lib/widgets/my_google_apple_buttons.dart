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

class MyGoogleAppleButtons extends StatelessWidget {
  const MyGoogleAppleButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MyImageButton(
          imagePath: 'assets/images/google.png',
          onTap: () {},
        ),
        const SizedBox(
          width: 20,
        ),
        MyImageButton(
          imagePath: 'assets/images/apple.png',
          onTap: () {},
        ),
      ],
    );
  }
}
