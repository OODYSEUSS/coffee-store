import 'package:coffee_store/screens/home/cart_screen.dart';
import 'package:coffee_store/screens/home/home_screen.dart';
import 'package:coffee_store/screens/home/profile_screen.dart';
import 'package:coffee_store/widgets/my_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:coffee_store/bloc/home/bottom_navigation_cubit.dart';

class HomeNavigation extends StatelessWidget {
  const HomeNavigation({super.key});

  final List<Widget> _pages = const [
    HomeScreen(),
    CartScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BottomNavigationCubit(),
      child: Scaffold(
        backgroundColor: const Color(0xFFF9F9F9),
        body: BlocBuilder<BottomNavigationCubit, int>(
          builder: (context, currentIndex) {
            return _pages[currentIndex];
          },
        ),
        bottomNavigationBar: MyBottomNavigationBar(),
      ),
    );
  }
}
