import 'package:coffee_store/widgets/my_profile_appbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  signUserOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacementNamed(context, '/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: MyProfileAppBar(),
      body: Center(
        child: ElevatedButton(
          onPressed: () => signUserOut(context),
          child: const Text('Sign Out'),
        ),
      ),
    );
  }
}
