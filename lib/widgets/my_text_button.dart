import 'package:flutter/material.dart';

class MyTextButton extends StatelessWidget {
  final Function()? onPressed;
  final String text;

  const MyTextButton({
    super.key,
    required this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: const TextStyle(
          color: Color.fromRGBO(198, 124, 78, 1.0),
          fontFamily: 'Sora',
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
