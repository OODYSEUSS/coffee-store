import 'package:flutter/material.dart';

class MyItemAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios_sharp),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: Text('Detail'),
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
