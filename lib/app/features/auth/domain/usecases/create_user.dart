import 'package:result_dart/result_dart.dart';
import 'package:store/app/commons/utils/Exceptions/custom_exception.dart';
import 'package:store/app/features/auth/domain/repositories/i_auth_repository.dart';

class CreateUser {
  final IAuthRepository repository;
  const CreateUser({required this.repository});

  AsyncResult<Unit, CustomException> create({required String email, required String password}) async {
    return await repository.createUserCredencial(email: email, password: password);
  }
}
