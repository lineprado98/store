import 'package:store/app/commons/services/auth/auth_error_type_enum.dart';
import 'package:store/app/commons/utils/Exceptions/custom_exception.dart';

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
}
