import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:coffee_store/bloc/authentication/reset_passw_cubit.dart';
import 'package:coffee_store/widgets/my_button.dart';
import 'package:coffee_store/widgets/my_text_field.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromRGBO(249, 249, 249, 1.0),
      body: BlocProvider(
        create: (context) => ResetPasswordCubit(),
        child: ResetPasswordScreen(),
      ),
    );
  }
}

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ResetPasswordCubit, ResetPasswordState>(
      builder: (context, state) {
        final resetPasswordCubit = BlocProvider.of<ResetPasswordCubit>(context);
        return Column(
          children: [
            Stack(
              children: [
                Image.asset(
                  'assets/images/top_cap2.PNG',
                  fit: BoxFit.fitWidth,
                ),
                Positioned(
                  top: 30,
                  left: 5,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_sharp,
                      size: 35,
                      color: Color.fromRGBO(249, 249, 249, 1.0),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Forgot Your password?',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 34,
                      fontFamily: 'Sora',
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'Enter the email address associated with your account.',
                      style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 20,
                        fontFamily: 'Sora',
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 20),
                  MyTextField(
                    controller: resetPasswordCubit.emailController,
                    hintText: 'Email',
                    obscureText: false,
                  ),
                  const SizedBox(height: 20),
                  MyButton(
                    onPressed: () {
                      if (state != ResetPasswordState.loading) {
                        resetPasswordCubit.resetUserPassword(context);
                      }
                    },
                    text: 'Reset',
                  ),
                ],
              ),
            ),
            Image.asset(
              'assets/images/bottom_cap.PNG',
              fit: BoxFit.fitWidth,
            ),
          ],
        );
      },
    );
  }
}
