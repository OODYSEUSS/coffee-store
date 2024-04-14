import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

final emailControllerAuth = TextEditingController();
final passwordControllerAuth = TextEditingController();

void clearTextFieldAuth() {
  emailControllerAuth.clear();
  passwordControllerAuth.clear();
}

enum LoginState { initial, loading, success, error }

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginState.initial);

  void signIn(String email, String password, BuildContext context) async {
    try {
      emit(LoginState.loading);

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

      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      Navigator.pop(context);
      Navigator.pushReplacementNamed(context, '/home');
      clearTextFieldAuth();
      emit(LoginState.success);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      clearTextFieldAuth();
      print('Authentication error: ${e.message}');
      emit(LoginState.error);
    } catch (e) {
      Navigator.pop(context);
      clearTextFieldAuth();
      print('Unexpected error: $e');
      emit(LoginState.error);
    }
  }
}

      //   Navigator.pop(context);
      //   Navigator.pushReplacementNamed(context, '/home');
      //   clearTextFieldAuth();
      //   emit(LoginState.success);
      // } on FirebaseAuthException catch (e) {
      //   Navigator.pop(context);
      //   clearTextFieldAuth();
      //   if (e.code == 'user-not-found') {
      //     print('No user found for that email');
      //   } else if (e.code == 'wrong-password') {
      //     print('Wrong password buddy');
      //   }
      //   emit(LoginState.error);