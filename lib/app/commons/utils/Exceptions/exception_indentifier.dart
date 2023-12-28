import 'package:store/app/commons/services/auth/auth_error_type_enum.dart';
import 'package:store/app/commons/services/database/database_error_type_enum.dart';
import 'package:store/app/commons/utils/exceptions/custom_exception.dart';

class ExceptionIdentifier {
  static CustomException handlerErrorAuth({required AuthErrorType type}) {
    switch (type) {
      case AuthErrorType.emailAlreadyExists:
        return EmailAlreadyExists();

      case AuthErrorType.userNotFound:
        return UserNotFound();

      case AuthErrorType.tooManyRequests:
        return TooManyRequests();

      case AuthErrorType.invalidPassword:
        return InvalidPassword();

      case AuthErrorType.emailAlreadyInUse:
        return EmailAlreadyInUse();

      default:
        return InternalError();
    }
  }

  static CustomException handlerErrorDatabase({required DatabaseErrorType type}) {
    switch (type) {
      case DatabaseErrorType.objectNotFound:
        return ObjectNotFound();

      case DatabaseErrorType.projectNotFound:
        return ProjectNotFound();

      case DatabaseErrorType.tooManyRequests:
        return TooManyRequests();

      case DatabaseErrorType.unauthenticated:
        return Unauthenticated();

      case DatabaseErrorType.unknown:
      default:
        return InternalError();
    }
  }
}
