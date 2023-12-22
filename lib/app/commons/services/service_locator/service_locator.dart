import 'package:get_it/get_it.dart';
import 'package:store/app/commons/services/database/database_firestore_service.dart';
import 'package:store/app/commons/services/database/i_database_service.dart';

GetIt getIt = GetIt.instance;

class ServiceLocator {
  static void setup() {
    //Services
    getIt.registerFactory<IDatabaseService>(() => DatabaseFirestoreService());
  }
}
