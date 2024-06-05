import 'package:coffee_store/screens/home/home_navigation_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) =>
                HomeNavigation()), // Замените HomePage на ваш виджет домашней страницы
        (Route<dynamic> route) => false, // Удаляет все предыдущие маршруты
      );
      clearTextFieldAuth();
      emit(LoginState.success);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      clearTextFieldAuth();
      print('Authentication error: ${e.message}');
      emit(LoginState.error);
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: const Color.fromRGBO(249, 249, 249, 1.0),
            title: Text('Error'),
            content:
                Text('Unable to verify account. Incorrect email or password.'),
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
    } catch (e) {
      Navigator.pop(context);
      clearTextFieldAuth();
      print('Unexpected error: $e');
      emit(LoginState.error);
    }
  }

  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      emit(LoginState.loading);

      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        emit(LoginState.error);
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);

      Navigator.pop(context);
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) =>
                HomeNavigation()), // Замените HomePage на ваш виджет домашней страницы
        (Route<dynamic> route) => false, // Удаляет все предыдущие маршруты
      );
      emit(LoginState.success);
    } catch (e) {
      Navigator.pop(context);
      print('Google sign in error: $e');
      emit(LoginState.error);
    }
  }
}
