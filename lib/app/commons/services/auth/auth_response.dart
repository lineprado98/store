import 'package:firebase_auth/firebase_auth.dart';
import 'package:store/app/commons/services/auth/auth_error_type_enum.dart';

class AuthResponse {
  final dynamic data;
  final bool? success;
  final String? message;
  final AuthErrorType? errorCode;

  const AuthResponse({this.data, this.success, this.message, this.errorCode});

  factory AuthResponse.fromSuccess(UserCredential userCredential) {
    return AuthResponse(data: userCredential, success: true, message: null);
  }
  factory AuthResponse.fromError(FirebaseAuthException excpetion) {
    return AuthResponse(data: null, success: false, message: excpetion.message, errorCode: fromFirebaseException(excpetion));
  }
  factory AuthResponse.fromUser(User? user) {
    return AuthResponse(data: user, success: true, message: null);
  }
}
