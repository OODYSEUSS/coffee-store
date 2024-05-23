import 'package:cached_network_image/cached_network_image.dart';
import 'package:coffee_store/bloc/home/cart_cubit.dart';
import 'package:coffee_store/widgets/my_item_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:coffee_store/data/coffee_model.dart';

class ItemScreen extends StatelessWidget {
  final Coffee coffee;

  const ItemScreen({super.key, required this.coffee});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: MyItemAppBar(),
      body: ListView(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: CachedNetworkImage(
              imageUrl: coffee.imageUrl,
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            coffee.name,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              fontFamily: 'Sora',
            ),
          ),
          const SizedBox(height: 10),
          Text(
            coffee.topping,
            style: const TextStyle(
              fontSize: 16,
              color: Color(0xFF9B9B9B),
              fontFamily: 'Sora',
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Icon(Icons.star_rate_rounded,
                  color: Color(0xFFFBBE21), size: 25),
              const SizedBox(width: 2),
              Text(
                coffee.point.toString(),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Sora',
                  color: Colors.black,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Divider(
            color: Color(0xFFEAEAEA),
            thickness: 1,
            height: 1,
          ),
          const SizedBox(
            height: 15,
          ),
          const Text(
            'Description',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'Sora',
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            coffee.description ?? 'No description available.',
            style: const TextStyle(
              color: Color(0xFF9B9B9B),
              fontFamily: 'Sora',
              fontWeight: FontWeight.w400, // Начертание Regular
              fontSize: 16,
            ),
          ),
          const SizedBox(
            height: 200,
          ),
          Container(
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
            child: Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text(
                      'Price',
                      style: TextStyle(
                        color: Color(0xFF9B9B9B),
                        fontFamily: 'Sora',
                        fontWeight: FontWeight.w400, // Начертание Regular
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      '\$ ${coffee.price.toString()}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Sora',
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                Spacer(),
                ElevatedButton(
                  onPressed: () {
                    context.read<CartCubit>().addToCart(coffee);
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(198, 124, 78, 1.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    minimumSize: const Size(217, 55),
                  ),
                  child: const Text(
                    'Add to cart',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Sora',
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
