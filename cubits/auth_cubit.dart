import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/user_model.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  void login(String email, String password) async {
    emit(AuthLoading() as AuthRegistered);

    if (email == "joe@gmail.com" && password == "12345") {
      final user = UserModel(
        id: '1',
        firstName: 'Test',
        lastName: 'User',
        email: email,
        passwordHash: 'hashed_password',
        createdAt: DateTime.now(),
      );
      emit(AuthSuccess(user) as AuthRegistered);
    } else {
      emit(AuthError('Invalid email or password', 'email') as AuthRegistered);
    }
  }

  void logout() {
    emit(AuthLoggedOut() as AuthRegistered);
  }

  void register(UserModel user) async {
    emit(AuthLoading() as AuthRegistered);
    await Future.delayed(Duration(seconds: 1));
    emit(AuthRegistered(user));
  }
}

void emit(AuthRegistered authRegistered) {
}
