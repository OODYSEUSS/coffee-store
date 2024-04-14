import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

enum RegistrationState { initial, loading, success, error }

class RegistrationCubit extends Cubit<RegistrationState> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  RegistrationCubit() : super(RegistrationState.initial);

  void clearTextFields() {
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
  }

  void signUserUp(BuildContext context) async {
    try {
      emit(RegistrationState.loading);

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

      if (passwordController.text == confirmPasswordController.text) {
        final userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );

        final user = userCredential.user;
        if (user != null) {
          await user.sendEmailVerification();
          Navigator.of(context).pop(); // закрываемм текущий экран
          Navigator.pushReplacementNamed(context, '/home');
        } else {
          print('User is null');
          emit(RegistrationState.error);
          clearTextFields();
          Navigator.of(context).pop();
        }
      } else {
        print('Password mismatch');
        emit(RegistrationState.error);
        clearTextFields();
        Navigator.of(context).pop();
      }

      emit(RegistrationState.success);
      clearTextFields();
    } on FirebaseAuthException catch (e) {
      Navigator.of(context).pop();
      print(e.code);
      emit(RegistrationState.error);
      clearTextFields();
    }
  }
}

//         await FirebaseAuth.instance
//             .createUserWithEmailAndPassword(
//               email: emailController.text,
//               password: passwordController.text,
//             )
//             .then((_) => Navigator.pushReplacementNamed(context, '/home'));
//         await FirebaseAuth.instance.currentUser!.sendEmailVerification();