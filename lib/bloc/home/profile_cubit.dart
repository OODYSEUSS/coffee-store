import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileState {
  final String name;
  final String email;
  final String phone;

  ProfileState({
    required this.name,
    required this.email,
    required this.phone,
  });

  get profileImageUrl => null;
}

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileState(name: '', email: '', phone: ''));

  Future<void> getUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot userData = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      emit(ProfileState(
        name: userData['name'],
        email: userData['email'],
        phone: userData['phone'],
      ));
    }
  }

  Future<void> signUserOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
