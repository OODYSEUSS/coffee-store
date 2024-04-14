import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

enum AuthState { authenticated, unauthenticated }

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthState.unauthenticated);

  void checkAuthentication() {
    FirebaseAuth.instance.authStateChanges().listen(
      (user) {
        if (user != null) {
          emit(AuthState.authenticated);
        } else {
          emit(AuthState.unauthenticated);
        }
      },
      onError: (error) {
        emit(AuthState.unauthenticated);
      },
    );
  }
}
