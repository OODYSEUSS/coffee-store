import 'package:flutter/material.dart';

class MyProfileAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text('Profile'),
      centerTitle: true,
      backgroundColor: const Color(0xFFF9F9F9),
      elevation: 0,
      titleTextStyle: const TextStyle(
        fontSize: 20,
        fontFamily: 'Sora',
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
      iconTheme: const IconThemeData(
        color: Colors.black,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
