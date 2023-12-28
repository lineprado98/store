import 'package:result_dart/result_dart.dart';
import 'package:store/app/commons/utils/exceptions/custom_exception.dart';
import 'package:store/app/features/auth/data/datasource/i_auth_datasource.dart';
import 'package:store/app/features/auth/data/dtos/user_dto.dart';
import 'package:store/app/features/auth/domain/entities/user_entity.dart';
import 'package:store/app/features/auth/domain/repositories/i_auth_repository.dart';

class AuthRepository implements IAuthRepository {
  final IAuthDatasource datasource;

  const AuthRepository({required this.datasource});

  @override
  AsyncResult<Unit, CustomException> createUserCredencial({
    required String email,
    required String password,
  }) async {
    try {
      await datasource.createUserCredencial(email: email, password: password);
      return Success.unit();
    } on CustomException catch (e) {
      return Failure(e);
    }
  }

  @override
  AsyncResult<UserEntity, CustomException> getUserStorage() async {
    try {
      final user = await datasource.getUserStorage();
      if (user != null) {
        return Success(user);
      }
      return Success(UserDto.empty());
    } on CustomException catch (e) {
      return Failure(e);
    }
  }

  @override
  AsyncResult<Unit, CustomException> signin({
    required String email,
    required String password,
  }) async {
    try {
      await datasource.signin(email: email, password: password);
      return Success.unit();
    } on CustomException catch (e) {
      return Failure(e);
    }
  }

  @override
  AsyncResult<Unit, CustomException> signout() async {
    try {
      await datasource.signout();
      return Success.unit();
    } on CustomException catch (e) {
      return Failure(e);
    }
  }
}
