import 'package:result_dart/result_dart.dart';
import 'package:store/app/commons/utils/exceptions/custom_exception.dart';
import 'package:store/app/features/auth/domain/entities/user_entity.dart';
import 'package:store/app/features/auth/domain/repositories/i_auth_repository.dart';

class GetUserData {
  final IAuthRepository repository;
  const GetUserData({required this.repository});

  AsyncResult<UserEntity, CustomException> getUser() async {
    return repository.getUserStorage();
  }
}
