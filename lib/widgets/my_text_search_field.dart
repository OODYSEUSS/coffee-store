import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:coffee_store/bloc/home/home_cubit.dart';

final searchController = TextEditingController();

class MyTextSearchField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;

  const MyTextSearchField({
    super.key,
    required this.controller,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        controller: controller,
        onChanged: (value) {
          context.read<CoffeeCubit>().filterCoffeeList(value);
        },
        decoration: InputDecoration(
          fillColor: const Color(0xFF313131),
          filled: true,
          hintText: hintText,
          suffixIcon: const Icon(
            Icons.search_rounded,
            size: 30,
            color: Color(0xFF989898),
          ),
          hintStyle: const TextStyle(
            color: Color(0xFF989898),
            fontFamily: 'Sora',
            fontSize: 14,
          ),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 17, horizontal: 20),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              color: Color(0xFF313131),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              color: Color(0xFF313131),
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: Colors.red.shade400,
              width: 2,
            ),
          ),
        ),
      ),
    );
  }
}
