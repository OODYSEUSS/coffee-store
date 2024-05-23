import 'package:cached_network_image/cached_network_image.dart';
import 'package:coffee_store/bloc/home/cart_cubit.dart';
import 'package:coffee_store/screens/home/item_screen.dart';
import 'package:coffee_store/screens/home/qr_code_screen.dart';
import 'package:coffee_store/widgets/my_cart_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:coffee_store/data/coffee_model.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: MyCartAppBar(),
      body: BlocBuilder<CartCubit, List<Coffee>>(
        builder: (context, cartItems) {
          if (cartItems.isEmpty) {
            return const Center(child: Text('Cart is empty'));
          }
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) {
                    Coffee coffee = cartItems[index];
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ItemScreen(coffee: coffee),
                          ),
                        );
                      },
                      child: ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 20),
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(7),
                          child: CachedNetworkImage(
                            imageUrl: coffee.imageUrl,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Text(coffee.name),
                        subtitle: Text('\$${coffee.price.toString()}'),
                        trailing: IconButton(
                          icon: Icon(Icons.remove_circle_outline),
                          onPressed: () {
                            context.read<CartCubit>().removeFromCart(coffee);
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            QrCodeScreen(cartItems: cartItems),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(400, 55),
                    backgroundColor: const Color.fromRGBO(198, 124, 78, 1.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'Create an order',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Sora',
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
