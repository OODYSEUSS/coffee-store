import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

enum ResetPasswordState { initial, loading, success, error }

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  final TextEditingController emailController = TextEditingController();

  ResetPasswordCubit() : super(ResetPasswordState.initial);

  void resetUserPassword(BuildContext context) async {
    try {
      emit(ResetPasswordState.loading);

      showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(
              backgroundColor: Color.fromRGBO(198, 124, 78, 1.0),
              color: Colors.white,
            ),
          );
        },
      );

      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: emailController.text,
      );

      emit(ResetPasswordState.success);
      Navigator.pop(context);
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Color.fromRGBO(249, 249, 249, 1.0),
            title: Text('Success'),
            content: Text('Password reset email sent.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.pushReplacementNamed(context, '/login');
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      print(e.code);
      emit(ResetPasswordState.error);
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Color.fromRGBO(249, 249, 249, 1.0),
            title: Text('Error'),
            content: Text('Password reset failed. ${e.message}'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  void clearTextFieldReset() {
    emailController.clear();
  }
}
