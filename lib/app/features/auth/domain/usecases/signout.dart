import 'package:result_dart/result_dart.dart';
import 'package:store/app/commons/utils/Exceptions/custom_exception.dart';
import 'package:store/app/features/auth/domain/repositories/i_auth_repository.dart';

class Signout {
  final IAuthRepository repository;
  const Signout({required this.repository});

  AsyncResult<Unit, CustomException> signout() async {
    return repository.signout();
  }
}
