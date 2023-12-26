import 'package:store/app/commons/services/storage/i_storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store/app/commons/utils/Exceptions/custom_exception.dart';

class SecureStorageService implements IStorageService {
  late final SharedPreferences storage;

  SecureStorageService() {
    initintanceShared();
  }

  Future<void> initintanceShared() async {
    storage = await SharedPreferences.getInstance();
  }

  @override
  Future<void> write({required String key, String? value}) async {
    try {
      //storage = await SharedPreferences.getInstance();
      await storage.setString(key, value ?? '');
    } catch (_) {
      throw StorageUnknown();
    }
  }

  @override
  Future<void> delete({required String key}) async {
    try {
      await storage.remove(key);
    } catch (_) {
      throw StorageUnknown();
    }
  }

  @override
  Future<String?> read({required String key}) async {
    try {
      final storage2 = await SharedPreferences.getInstance();
      if (storage2.containsKey(key)) {
        return storage2.getString(key);
      }
      return null;
    } catch (_) {
      throw StorageUnknown();
    }
  }
}
