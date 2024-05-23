import 'package:coffee_store/bloc/home/cart_cubit.dart';
import 'package:coffee_store/screens/authentication/auth_navigation_screen.dart';
import 'package:coffee_store/screens/authentication/login_screen.dart';
import 'package:coffee_store/screens/authentication/register_screen.dart';
import 'package:coffee_store/screens/authentication/reset_passw_screen.dart';
import 'package:coffee_store/screens/home/home_navigation_screen.dart';
import 'package:coffee_store/screens/home/home_screen.dart';
import 'package:coffee_store/screens/onboarding/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const Application(),
  );
}

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => CartCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => const Auth(),
          '/start': (context) => const OnboardingScreen(),
          '/login': (context) => const Login(),
          '/reset': (context) => const ResetPassword(),
          '/register': (context) => const Register(),
          '/home': (context) => HomeNavigation(),
          '/mainhome': (context) => HomeScreen(),
        },
      ),
    );
  }
}
