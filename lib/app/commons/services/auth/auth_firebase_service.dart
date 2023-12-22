import 'package:store/app/commons/services/auth/auth_response.dart';
import 'package:store/app/commons/services/auth/i_auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService implements IAuthService {
  final firebaseAuth = FirebaseAuth;
  const FirebaseAuthService();

  @override
  Future<AuthResponse> signin({required String password, required String email}) {
    // TODO: implement signin
    throw UnimplementedError();
  }

  @override
  Future<AuthResponse> signout() {
    // TODO: implement signout
    throw UnimplementedError();
  }

  @override
  Future<AuthResponse> signup({required String password, required String email}) {
    // TODO: implement signup
    throw UnimplementedError();
  }

  @override
  Future<AuthResponse> userlogged() {
    // TODO: implement userlogged
    throw UnimplementedError();
  }
}
