import 'package:coffee_store/screens/home/home_navigation_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Добавлен импорт для Firestore

enum RegistrationState { initial, loading, success, error }

class RegistrationCubit extends Cubit<RegistrationState> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  RegistrationCubit() : super(RegistrationState.initial);

  void clearTextFields() {
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    nameController.clear();
    phoneController.clear();
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

          // Сохраняем дополнительные данные в Firestore
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .set({
            'email': emailController.text,
            'name': nameController.text,
            'phone': phoneController.text,
          });

          Navigator.of(context).pop(); // Закрываем текущий экран
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    HomeNavigation()), // Замените HomePage на ваш виджет домашней страницы
            (Route<dynamic> route) => false, // Удаляет все предыдущие маршруты
          );
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
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: Color.fromRGBO(249, 249, 249, 1.0),
              title: Text('Error'),
              content: Text('Passwords do not match.'),
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

      emit(RegistrationState.success);
      clearTextFields();
    } on FirebaseAuthException catch (e) {
      Navigator.of(context).pop();
      print(e.code);
      emit(RegistrationState.error);
      clearTextFields();
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Color.fromRGBO(249, 249, 249, 1.0),
            title: Text('Error'),
            content: Text('Registration failed. ${e.message}'),
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
}
