import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ielts_tev/domains/authentication_repository/authentication_repository.dart';
import 'package:ielts_tev/presentation/register/bloc/register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final AuthenticationRepository authenticationRepository;

  RegisterCubit({required this.authenticationRepository})
      : super(RegisterState());

  Future<void> reigster(String email, String password) async {
    try {
      FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
    } catch (e) {}
  }
}
