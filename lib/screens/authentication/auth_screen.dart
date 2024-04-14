import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:coffee_store/screens/home/home_screen.dart';
import 'package:coffee_store/screens/onboarding/onboarding_screen.dart';
import 'package:coffee_store/bloc/authentication/auth_cubit.dart';

class Auth extends StatelessWidget {
  const Auth({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final authCubit = AuthCubit();
        authCubit.checkAuthentication();
        return authCubit;
      },
      child: const AuthScreen(),
    );
  }
}

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, authState) {
        if (authState == AuthState.authenticated) {
          return const HomeScreen();
        } else {
          return const OnboardingScreen();
        }
      },
    );
  }
}
