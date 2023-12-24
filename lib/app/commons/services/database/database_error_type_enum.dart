import 'package:firebase_auth/firebase_auth.dart';

enum DatabaseErrorType { unknown, objectNotFound, projectNotFound, unauthenticated, tooManyRequests }

DatabaseErrorType fromFirebaseException(FirebaseException e) {
  switch (e.code) {
    case 'object-not-found':
      return DatabaseErrorType.objectNotFound;

    case 'project-not-found':
      return DatabaseErrorType.projectNotFound;

    case 'unauthenticated':
      return DatabaseErrorType.unauthenticated;

    default:
      return DatabaseErrorType.unknown;
  }
}
