import 'package:result_dart/result_dart.dart';
import 'package:store/app/commons/utils/Exceptions/custom_exception.dart';
import 'package:store/app/features/auth/domain/entities/user_entity.dart';

abstract class IAuthRepository {
  AsyncResult<Unit, CustomException> createUserCredencial({required String email, required String password});
  AsyncResult<Unit, CustomException> signin({required String email, required String password});
  AsyncResult<Unit, CustomException> signout();
  AsyncResult<UserEntity, CustomException> getUserStorage();
}
