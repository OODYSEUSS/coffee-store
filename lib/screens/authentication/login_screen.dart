import 'package:coffee_store/bloc/authentication/login_cubit.dart';
import 'package:coffee_store/widgets/my_button.dart';
import 'package:coffee_store/widgets/my_google_apple_buttons.dart';
import 'package:coffee_store/widgets/my_text_button.dart';
import 'package:coffee_store/widgets/my_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromRGBO(249, 249, 249, 1.0),
      body: Center(
        child: BlocProvider(
          create: (context) => LoginCubit(),
          child: const LoginScreen(),
        ),
      ),
    );
  }
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loginCubit = BlocProvider.of<LoginCubit>(context);
    return Column(
      children: [
        Stack(
          children: [
            Image.asset(
              'assets/images/top_cap.PNG',
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
        const SizedBox(
          height: 30,
        ),
        const Text(
          'Login',
          style: TextStyle(
            color: Colors.black,
            fontSize: 34,
            fontFamily: 'Sora',
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        MyTextField(
          controller: emailControllerAuth,
          hintText: 'Email',
          obscureText: false,
        ),
        const SizedBox(
          height: 15,
        ),
        MyTextField(
          controller: passwordControllerAuth,
          hintText: 'Password',
          obscureText: true,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MyTextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/reset');
                },
                text: 'Reset password',
              ),
              MyTextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/register');
                },
                text: 'Sign up for an account.',
              )
            ],
          ),
        ),
        BlocBuilder<LoginCubit, LoginState>(
          builder: (context, state) {
            return MyButton(
              onPressed: () {
                if (state != LoginState.loading) {
                  loginCubit.signIn(
                    emailControllerAuth.text,
                    passwordControllerAuth.text,
                    context,
                  );
                }
              },
              text: 'Sign In',
            );
          },
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Or sign in with',
                style: TextStyle(
                  color: Colors.grey.shade500,
                  fontSize: 20,
                  fontFamily: 'Sora',
                  fontWeight: FontWeight.w600,
                ),
              ),
              const MyGoogleAppleButtons(),
            ],
          ),
        ),
        Image.asset(
          'assets/images/bottom_cap.PNG',
          fit: BoxFit.fitWidth,
        ),
      ],
    );
  }
}
