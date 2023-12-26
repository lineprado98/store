import 'dart:convert';
import 'package:store/app/commons/services/auth/i_auth_service.dart';
import 'package:store/app/commons/services/storage/i_storage_service.dart';
import 'package:store/app/commons/utils/Exceptions/exception_indentifier.dart';
import 'package:store/app/commons/utils/storage_keys.dart';
import 'package:store/app/features/auth/data/datasource/i_auth_datasource.dart';
import 'package:store/app/features/auth/data/dtos/user_dto.dart';

class AuthDatasource implements IAuthDatasource {
  final IAuthService auth;
  final IStorageService storage;
  const AuthDatasource({required this.auth, required this.storage});

  @override
  Future<void> createUserCredencial({required UserDto user}) async {
    final result = await auth.signup(password: user.userPassword, email: user.userEmail);

    if (result.success == false) {
      ExceptionIdentifier.handlerErrorAuth(type: result.errorCode!);
    }
    try {
      await signin(user: user);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> signin({required UserDto user}) async {
    final result = await auth.signin(password: user.userPassword, email: user.userEmail);
    if (result.success == false) {
      throw ExceptionIdentifier.handlerErrorAuth(type: result.errorCode!);
    }

    try {
      await saveUserStorage(user: user);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> signout() async {
    final result = await auth.signout();
    if (result.success == false) {
      throw ExceptionIdentifier.handlerErrorAuth(type: result.errorCode!);
    }
    try {
      await deleteUserStorage();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> saveUserStorage({required UserDto user}) async {
    try {
      await storage.write(key: StorageKeys.user, value: jsonEncode(user.toJson()));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteUserStorage() async {
    try {
      await storage.delete(key: StorageKeys.user);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserDto?> getUserStorage() async {
    try {
      final userJsonString = await storage.read(key: StorageKeys.user);

      if (userJsonString != null) {
        final userMap = jsonDecode(userJsonString);
        return UserDto.fromJson(json: userMap);
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }
}
