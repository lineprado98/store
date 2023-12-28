import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:result_dart/result_dart.dart';
import 'package:store/app/commons/utils/exceptions/custom_exception.dart';
import 'package:store/app/features/auth/domain/repositories/i_auth_repository.dart';
import 'package:store/app/features/auth/domain/usecases/signout.dart';

class AuthRepositoryMock extends Mock implements IAuthRepository {}

void main() {
  late IAuthRepository authRespository;
  late Signout signout;
  setUp(() {
    authRespository = AuthRepositoryMock();
    signout = Signout(repository: authRespository);
  });

  test('Should return a success when sign out app', () async {
    //arrange

    when(() => authRespository.signout()).thenAnswer((_) async => Result.success(unit));

    //act
    final result = await signout.signout();

    //assert
    expect(result, isA<Result<Unit, CustomException>>());
    expect(result.isSuccess(), true);
  });

  test('Should return a exception when sign out app ', () async {
    //arrange

    when(() => authRespository.signout()).thenAnswer((_) async => Result.failure(InternalError()));

    //act
    final result = await signout.signout();

    //assert
    expect(result, isA<Result<Unit, CustomException>>());
    expect(result.isError(), true);
  });
}
