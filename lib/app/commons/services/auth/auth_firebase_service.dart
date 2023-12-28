import 'package:store/app/commons/services/auth/auth_response.dart';
import 'package:store/app/commons/services/auth/i_auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthFirebaseService implements IAuthService {
  late final FirebaseAuth firebaseAuth;
  AuthFirebaseService() {
    firebaseAuth = FirebaseAuth.instance;
  }

  @override
  Future<AuthResponse> signin({required String password, required String email}) async {
    try {
      final response = await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);

      return AuthResponse.fromSuccess(response);
    } on FirebaseAuthException catch (e) {
      return AuthResponse.fromError(e);
    }
  }

  @override
  Future<AuthResponse> signout() async {
    try {
      await firebaseAuth.signOut();
      return const AuthResponse(success: true);
    } on FirebaseAuthException catch (e) {
      return AuthResponse.fromError(e);
    }
  }

  @override
  Future<AuthResponse> signup({required String password, required String email}) async {
    try {
      final response = await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      return AuthResponse.fromSuccess(response);
    } on FirebaseAuthException catch (e) {
      return AuthResponse.fromError(e);
    }
  }

  @override
  Future<AuthResponse> userIsLogged() async {
    try {
      final response = firebaseAuth.currentUser;
      return AuthResponse.fromUser(response);
    } on FirebaseAuthException catch (e) {
      return AuthResponse.fromError(e);
    }
  }
}
