import 'package:coffee_store/bloc/authentication/register_cubit.dart';
import 'package:coffee_store/widgets/my_button.dart';
import 'package:coffee_store/widgets/my_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Register extends StatelessWidget {
  const Register({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromRGBO(249, 249, 249, 1.0),
      body: BlocProvider(
        create: (context) => RegistrationCubit(),
        child: const RegisterScreen(),
      ),
    );
  }
}

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final registrationCubit = BlocProvider.of<RegistrationCubit>(context);
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
                'Register',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 34,
                  fontFamily: 'Sora',
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 15),
              MyTextField(
                controller: registrationCubit.emailController,
                hintText: 'Email',
                obscureText: false,
              ),
              const SizedBox(height: 15),
              MyTextField(
                controller: registrationCubit.passwordController,
                hintText: 'Password',
                obscureText: true,
              ),
              const SizedBox(height: 15),
              MyTextField(
                controller: registrationCubit.confirmPasswordController,
                hintText: 'Confirm password',
                obscureText: true,
              ),
              const SizedBox(height: 15),
              MyTextField(
                controller: registrationCubit.nameController,
                hintText: 'Name',
                obscureText: false,
              ),
              const SizedBox(height: 15),
              MyTextField(
                controller: registrationCubit.phoneController,
                hintText: 'Phone',
                obscureText: false,
              ),
              const SizedBox(height: 15),
              const SizedBox(height: 20),
              BlocBuilder<RegistrationCubit, RegistrationState>(
                builder: (context, state) {
                  return MyButton(
                    onPressed: () {
                      if (state != RegistrationState.loading) {
                        registrationCubit.signUserUp(context);
                      }
                    },
                    text: 'Sign Up',
                  );
                },
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
  }
}
