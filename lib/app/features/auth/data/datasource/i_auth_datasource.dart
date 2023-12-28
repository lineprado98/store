import 'package:store/app/features/auth/data/dtos/user_dto.dart';

abstract class IAuthDatasource {
  Future<void> createUserCredencial({required String email, required String password});
  Future<void> signin({required String email, required String password});
  Future<void> signout();
  Future<void> saveUserStorage({required UserDto user});
  Future<void> deleteUserStorage();
  Future<UserDto?> getUserStorage();
}
