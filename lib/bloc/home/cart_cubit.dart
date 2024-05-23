import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:coffee_store/data/coffee_model.dart';

class CartCubit extends Cubit<List<Coffee>> {
  CartCubit() : super([]) {
    _loadCart();
  }

  void addToCart(Coffee coffee) {
    final updatedCart = List<Coffee>.from(state)..add(coffee);
    emit(updatedCart);
    _saveCart(updatedCart);
  }

  void removeFromCart(Coffee coffee) {
    final updatedCart = List<Coffee>.from(state)..remove(coffee);
    emit(updatedCart);
    _saveCart(updatedCart);
  }

  Future<void> _loadCart() async {
    final prefs = await SharedPreferences.getInstance();
    final cartJson = prefs.getString('cart');
    if (cartJson != null) {
      final List<dynamic> cartList = json.decode(cartJson);
      final loadedCart = cartList.map((item) => Coffee.fromJson(item)).toList();
      emit(loadedCart);
    }
  }

  Future<void> _saveCart(List<Coffee> cart) async {
    final prefs = await SharedPreferences.getInstance();
    final cartJson = json.encode(cart.map((item) => item.toJson()).toList());
    await prefs.setString('cart', cartJson);
  }
}
