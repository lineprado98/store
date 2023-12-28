import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:result_dart/result_dart.dart';
import 'package:store/app/commons/utils/exceptions/custom_exception.dart';
import 'package:store/app/features/auth/domain/repositories/i_auth_repository.dart';
import 'package:store/app/features/auth/domain/usecases/create_user.dart';

class AuthRepositoryMock extends Mock implements IAuthRepository {}

void main() {
  late IAuthRepository authRespository;
  late CreateUser createUser;
  setUp(() {
    authRespository = AuthRepositoryMock();
    createUser = CreateUser(repository: authRespository);
  });

  test('Should return a success when create a user', () async {
    //arrange
    const String email = 'teste@gmail.com';
    const String password = '123456';

    when(() => authRespository.createUserCredencial(email: email, password: password)).thenAnswer((_) async => Result.success(unit));

    //act
    final result = await createUser.create(email: email, password: password);

    //assert
    expect(result, isA<Result<Unit, CustomException>>());
    expect(result.isSuccess(), true);
  });

  test('Should return a customException when create user ', () async {
    //arrange
    const String email = 'emailinvalido.com';
    const String password = '12345';
    when(() => authRespository.createUserCredencial(email: email, password: password)).thenAnswer((_) async => Result.failure(FailedCreateAccount()));

    //act
    final result = await createUser.create(email: email, password: password);

    //assert
    expect(result, isA<Result<Unit, CustomException>>());
    expect(result.isError(), true);
  });
}
