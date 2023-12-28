import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:result_dart/result_dart.dart';
import 'package:store/app/commons/utils/exceptions/custom_exception.dart';
import 'package:store/app/features/auth/domain/entities/user_entity.dart';
import 'package:store/app/features/auth/domain/repositories/i_auth_repository.dart';
import 'package:store/app/features/auth/domain/usecases/get_user_data.dart';

class AuthRepositoryMock extends Mock implements IAuthRepository {}

void main() {
  late IAuthRepository authRespository;
  late GetUserData getUserData;
  setUp(() {
    authRespository = AuthRepositoryMock();
    getUserData = GetUserData(repository: authRespository);
  });

  test('Should return a success when get user data ', () async {
    //arrange
    const UserEntity userdata = UserEntity(name: 'Name teste', email: 'email@email.com', id: '');

    when(() => authRespository.getUserStorage()).thenAnswer((_) async => Result.success(userdata));

    //act
    final result = await getUserData.getUser();

    //assert
    expect(result, isA<Result<UserEntity, CustomException>>());
    expect(result.isSuccess(), true);
  });

  test('Should return a customException when get user data ', () async {
    //arrange

    when(() => authRespository.getUserStorage()).thenAnswer((_) async => Result.failure(DatabaseFailure()));

    //act
    final result = await getUserData.getUser();

    //assert
    expect(result, isA<Result<UserEntity, CustomException>>());
    expect(result.isError(), true);
  });
}
