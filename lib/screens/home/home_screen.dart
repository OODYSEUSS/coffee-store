import 'package:coffee_store/bloc/home/bottom_navigation_cubit.dart';
import 'package:coffee_store/widgets/my_home_appbar.dart';
import 'package:coffee_store/widgets/my_menu_grid.dart';
import 'package:flutter/material.dart';
import 'package:coffee_store/widgets/my_category_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BottomNavigationCubit(),
      child: Scaffold(
        backgroundColor: const Color(0xFFF9F9F9),
        // backgroundColor: Colors.black,
        body: ListView(
          padding: EdgeInsets.zero,
          children: [
            MyHomeAppBar(),
            const SizedBox(height: 10),
            // const MyCategory(),
            const SizedBox(height: 10),
            MyMenuGrid(),
          ],
        ),
      ),
    );
  }
}
