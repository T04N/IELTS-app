import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domains/authentication_repository/authentication_repository.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthenticationRepository authenticationRepository;

  LoginCubit({required this.authenticationRepository}) : super(LoginState(""));

  Future<void> login(String email, String password) async {
    try {
      await authenticationRepository.loginWithEmailandPassword(email: email, password: password);
    } catch (E) {
      print(E);
    }

    print("Login with $email and password $password");
  }
}
