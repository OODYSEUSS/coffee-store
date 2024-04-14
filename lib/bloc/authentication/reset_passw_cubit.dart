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
      Navigator.pushReplacementNamed(context, '/login');
    } on FirebaseAuthException catch (e) {
      print(e.code);
      emit(ResetPasswordState.error);
    } finally {
      Navigator.pop(context);
    }
  }

  void clearTextFieldReset() {
    emailController.clear();
  }
}
