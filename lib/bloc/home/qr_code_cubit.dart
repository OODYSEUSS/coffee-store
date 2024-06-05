import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class QrCodeState {
  final String userName;
  final List<String> cartIds;

  QrCodeState({required this.userName, required this.cartIds});
}

class QrCodeCubit extends Cubit<QrCodeState> {
  QrCodeCubit() : super(QrCodeState(userName: '', cartIds: []));

  Future<void> getUserName(List<String> cartIds) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot userData = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      emit(QrCodeState(
        userName: userData['name'],
        cartIds: cartIds,
      ));
    }
  }
}
