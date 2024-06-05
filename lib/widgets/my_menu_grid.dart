import 'package:coffee_store/bloc/home/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:coffee_store/bloc/home/home_cubit.dart';
import 'package:coffee_store/data/coffee_model.dart';
import 'package:coffee_store/screens/home/item_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MyMenuGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CoffeeCubit, CoffeeState>(
      builder: (context, state) {
        if (state == CoffeeState.loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state == CoffeeState.loaded) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.63,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: filteredCoffeeList.length,
              itemBuilder: (BuildContext context, int index) {
                Coffee coffee = filteredCoffeeList[index];
                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 5,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ItemScreen(coffee: coffee),
                                    ),
                                  );
                                },
                                child: CachedNetworkImage(
                                  imageUrl: coffee.imageUrl,
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 10,
                            left: 10,
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.star_rate_rounded,
                                  color: Color(0xFFFBBE21),
                                  size: 25,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  coffee.point.toString(),
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'Sora',
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Text(
                        coffee.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontFamily: 'Sora',
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        coffee.topping,
                        style: const TextStyle(
                          fontSize: 14,
                          fontFamily: 'Sora',
                          fontWeight: FontWeight.normal,
                          color: Color(0xFF9B9B9B),
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 5, left: 5, right: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '\$ ${coffee.price.toString()}',
                              style: const TextStyle(
                                fontSize: 18,
                                fontFamily: 'Sora',
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                context.read<CartCubit>().addToCart(coffee);
                              },
                              icon: Icon(Icons.add_rounded),
                              color: Colors.white,
                              iconSize: 20,
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromRGBO(198, 124, 78, 1.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        } else if (state == CoffeeState.error) {
          return const Center(child: Text('Failed to load coffee!'));
        } else {
          return Container();
        }
      },
    );
  }
}
