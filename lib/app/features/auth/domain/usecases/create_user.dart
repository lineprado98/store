import 'package:result_dart/result_dart.dart';
import 'package:store/app/commons/utils/Exceptions/custom_exception.dart';
import 'package:store/app/features/auth/domain/entities/user_entity.dart';
import 'package:store/app/features/auth/domain/repositories/i_auth_repository.dart';

class CreateUser {
  final IAuthRepository repository;
  const CreateUser({required this.repository});

  AsyncResult<Unit, CustomException> create({required UserEntity user}) async {
    return await repository.createUserCredencial(user: user);
  }
}
