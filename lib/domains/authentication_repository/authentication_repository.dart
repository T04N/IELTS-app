import 'package:ielts_tev/domains/data_sources/firebase_auth_service.dart';

abstract class AuthenticationRepository {
  Future<void> loginWithEmailandPassword(
      {required String email, required String password});
}

class AuthenticationRepositoryIML extends AuthenticationRepository {
  FirebaseAuthService firebaseAuthService;

  AuthenticationRepositoryIML({required this.firebaseAuthService});

  @override
  Future<void> loginWithEmailandPassword(
      {required String email, required String password}) async {
    try {
      firebaseAuthService.loginWithEmailandPassword(email: email, password: password) ;
    } catch (e) {
      print("error $e ");
    }
  }
}
