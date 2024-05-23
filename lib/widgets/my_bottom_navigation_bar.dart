import 'package:coffee_store/bloc/home/bottom_navigation_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyBottomNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavigationCubit, int>(
      builder: (context, currentIndex) {
        return Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color(0xFFF1F1F1),
              width: 1.0,
            ),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
            child: BottomNavigationBar(
              showSelectedLabels: false,
              showUnselectedLabels: false,
              backgroundColor: const Color(0xFFF9F9F9),
              onTap: (index) {
                context.read<BottomNavigationCubit>().updateIndex(index);
              },
              currentIndex: currentIndex,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_rounded),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_basket_rounded),
                  label: 'Cart',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person_4),
                  label: 'Profile',
                ),
              ],
              selectedItemColor: Color.fromRGBO(198, 124, 78, 1.0),
            ),
          ),
        );
      },
    );
  }
}
