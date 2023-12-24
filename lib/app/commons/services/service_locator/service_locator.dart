import 'package:get_it/get_it.dart';
import 'package:store/app/commons/services/auth/auth_firebase_service.dart';
import 'package:store/app/commons/services/auth/i_auth_service.dart';
import 'package:store/app/commons/services/database/database_firestore_service.dart';
import 'package:store/app/commons/services/database/i_database_service.dart';
import 'package:store/app/commons/services/storage/i_storage_service.dart';
import 'package:store/app/commons/services/storage/secure_storage_service.dart';
import 'package:store/app/features/auth/data/datasource/auth_datasource.dart';
import 'package:store/app/features/auth/data/datasource/i_auth_datasource.dart';
import 'package:store/app/features/auth/data/repositories/auth_repository.dart';
import 'package:store/app/features/auth/domain/repositories/i_auth_repository.dart';
import 'package:store/app/features/auth/domain/usecases/create_user.dart';
import 'package:store/app/features/auth/domain/usecases/get_user_data.dart';
import 'package:store/app/features/auth/domain/usecases/signin.dart';
import 'package:store/app/features/auth/domain/usecases/signout.dart';

GetIt getIt = GetIt.instance;

class ServiceLocator {
  static void setup() {
    //Services
    getIt.registerFactory<IDatabaseService>(() => DatabaseFirestoreService());
    getIt.registerFactory<IStorageService>(() => SecureStorageService());
    getIt.registerFactory<IAuthService>(() => AuthFirebaseService());

    //Datasources
    getIt.registerFactory<IAuthDatasource>(() => AuthDatasource(
          auth: getIt.get<IAuthService>(),
          storage: getIt.get<IStorageService>(),
        ));

    //repositories
    getIt.registerFactory<IAuthRepository>(() => AuthRepository(datasource: getIt.get<IAuthDatasource>()));

    //usecases
    getIt.registerFactory<CreateUser>(() => CreateUser(repository: getIt.get<IAuthRepository>()));
    getIt.registerFactory<GetUserData>(() => GetUserData(repository: getIt.get<IAuthRepository>()));
    getIt.registerFactory<Signin>(() => Signin(repository: getIt.get<IAuthRepository>()));
    getIt.registerFactory<Signout>(() => Signout(repository: getIt.get<IAuthRepository>()));
  }
}
