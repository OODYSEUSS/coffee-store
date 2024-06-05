import 'package:coffee_store/bloc/home/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:coffee_store/widgets/my_profile_appbar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  void signUserOut(BuildContext context) async {
    await context.read<ProfileCubit>().signUserOut();
    Navigator.pushReplacementNamed(context, '/');
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProfileCubit()..getUserData(),
      child: Scaffold(
        backgroundColor: const Color(0xFFF9F9F9),
        appBar: MyProfileAppBar(),
        body: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Профильное изображение
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/images/user_photo.png'),
                  ),
                  const SizedBox(height: 16),
                  // Карточка с информацией о пользователе
                  Card(
                    color: Colors.white,
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.person, color: Colors.grey),
                              const SizedBox(width: 8),
                              Text('${state.name}',
                                  style: TextStyle(fontSize: 18)),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(Icons.email, color: Colors.grey),
                              const SizedBox(width: 8),
                              Text('${state.email}',
                                  style: TextStyle(fontSize: 18)),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(Icons.phone, color: Colors.grey),
                              const SizedBox(width: 8),
                              Text('${state.phone}',
                                  style: TextStyle(fontSize: 18)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
                  // Кнопка выхода из аккаунта

                  ElevatedButton(
                    onPressed: () {
                      signUserOut(context);
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(400, 55),
                      backgroundColor: const Color.fromRGBO(198, 124, 78, 1.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text(
                      'Sign Out',
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
            );
          },
        ),
      ),
    );
  }
}
