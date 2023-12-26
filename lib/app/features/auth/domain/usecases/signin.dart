import 'package:result_dart/result_dart.dart';
import 'package:store/app/commons/utils/Exceptions/custom_exception.dart';
import 'package:store/app/features/auth/domain/repositories/i_auth_repository.dart';

class Signin {
  final IAuthRepository repository;
  const Signin({required this.repository});

  AsyncResult<Unit, CustomException> signin({required String email, required String password}) async {
    return await repository.signin(email: email, password: password);
  }
}
