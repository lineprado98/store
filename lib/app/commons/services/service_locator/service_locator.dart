import 'package:get_it/get_it.dart';
import 'package:store/app/commons/services/auth/auth_firebase_service.dart';
import 'package:store/app/commons/services/auth/i_auth_service.dart';
import 'package:store/app/commons/services/database/database_firestore_service.dart';
import 'package:store/app/commons/services/database/i_database_service.dart';
import 'package:store/app/commons/services/storage/i_storage_service.dart';
import 'package:store/app/commons/services/storage/storage_service.dart';
import 'package:store/app/features/auth/data/datasource/auth_datasource.dart';
import 'package:store/app/features/auth/data/datasource/i_auth_datasource.dart';
import 'package:store/app/features/auth/data/repositories/auth_repository.dart';
import 'package:store/app/features/auth/domain/repositories/i_auth_repository.dart';
import 'package:store/app/features/auth/domain/usecases/create_user.dart';
import 'package:store/app/features/auth/domain/usecases/get_user_data.dart';
import 'package:store/app/features/auth/domain/usecases/signin.dart';
import 'package:store/app/features/auth/domain/usecases/signout.dart';
import 'package:store/app/features/product/data/datasource/i_product_datasource.dart';
import 'package:store/app/features/product/data/datasource/product_datasource.dart';
import 'package:store/app/features/product/data/repositories/product_repository.dart';
import 'package:store/app/features/product/domain/repositories/i_product_repository.dart';
import 'package:store/app/features/product/domain/usecases/create_product.dart';
import 'package:store/app/features/product/domain/usecases/delete_product.dart';
import 'package:store/app/features/product/domain/usecases/list_product.dart';
import 'package:store/app/features/product/domain/usecases/update_product.dart';

GetIt getIt = GetIt.instance;

class ServiceLocator {
  static void setup() {
    //SERVICES
    getIt.registerFactory<IDatabaseService>(() => DatabaseFirestoreService());
    getIt.registerFactory<IStorageService>(() => const StorageService());
    getIt.registerFactory<IAuthService>(() => AuthFirebaseService());

    //DATASOURCES
    getIt.registerFactory<IAuthDatasource>(() => AuthDatasource(
          auth: getIt.get<IAuthService>(),
          storage: getIt.get<IStorageService>(),
        ));
    getIt.registerFactory<IProductDatasource>(() => ProductDatasource(
          database: getIt.get<IDatabaseService>(),
        ));

    //REPOSITORIES
    getIt.registerFactory<IAuthRepository>(() => AuthRepository(datasource: getIt.get<IAuthDatasource>()));
    getIt.registerFactory<IProductRespository>(() => ProductRepository(datasource: getIt.get<IProductDatasource>()));

    //USECASES-USER
    getIt.registerFactory<CreateUser>(() => CreateUser(repository: getIt.get<IAuthRepository>()));
    getIt.registerFactory<GetUserData>(() => GetUserData(repository: getIt.get<IAuthRepository>()));
    getIt.registerFactory<Signin>(() => Signin(repository: getIt.get<IAuthRepository>()));
    getIt.registerFactory<Signout>(() => Signout(repository: getIt.get<IAuthRepository>()));

    //USECASES-PRODUTO
    getIt.registerFactory<CreateProduct>(() => CreateProduct(repository: getIt.get<IProductRespository>()));
    getIt.registerFactory<DeleteProduct>(() => DeleteProduct(repository: getIt.get<IProductRespository>()));
    getIt.registerFactory<ListProduct>(() => ListProduct(repository: getIt.get<IProductRespository>()));
    getIt.registerFactory<UpdateProduct>(() => UpdateProduct(repository: getIt.get<IProductRespository>()));
  }
}
