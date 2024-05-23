import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:coffee_store/data/coffee_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

enum CoffeeState { initial, loading, loaded, error }

List<Coffee> coffeeList = [];

class CoffeeCubit extends Cubit<CoffeeState> {
  CoffeeCubit() : super(CoffeeState.initial);

  Future<void> getCoffeeMenu() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? cachedMenu = prefs.getString('cachedMenu');

    if (cachedMenu != null) {
      List<dynamic> cachedData = jsonDecode(cachedMenu);
      coffeeList = cachedData.map((data) => Coffee.fromJson(data)).toList();
      emit(CoffeeState.loaded);
      return;
    }

    try {
      emit(CoffeeState.loading);

      DatabaseReference coffeeRef =
          FirebaseDatabase.instance.ref().child('coffee');
      DatabaseEvent event = await coffeeRef.once();
      DataSnapshot snapshot = event.snapshot;

      if (snapshot.value != null) {
        Map<dynamic, dynamic> values = snapshot.value as Map<dynamic, dynamic>;
        coffeeList = values.values
            .map((value) => Coffee.fromJson(Map<String, dynamic>.from(value)))
            .toList();

        // сохранениев SharedPreferences
        String menuJson =
            jsonEncode(coffeeList.map((coffee) => coffee.toJson()).toList());
        await prefs.setString('cachedMenu', menuJson);

        emit(CoffeeState.loaded);
      } else {
        print("Snapshot value is null");
        emit(CoffeeState.error);
      }
    } catch (e) {
      print("Error loading coffee menu: $e");
      emit(CoffeeState.error);
    }
  }
}
