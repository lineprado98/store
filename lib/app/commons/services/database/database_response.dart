import 'package:firebase_auth/firebase_auth.dart';
import 'package:store/app/commons/services/database/database_error_type_enum.dart';

class DatabaseResponse {
  final dynamic data;
  final bool success;
  final String? message;
  final DatabaseErrorType? errorCode;

  const DatabaseResponse({this.data, required this.success, this.message, this.errorCode});

  factory DatabaseResponse.fromSucces({dynamic data}) {
    return DatabaseResponse(data: data, success: true);
  }
  factory DatabaseResponse.fromError({required FirebaseException error}) {
    return DatabaseResponse(success: false, errorCode: fromFirebaseException(error));
  }
}
