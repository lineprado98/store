import 'package:store/app/commons/services/storage/i_storage_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService implements IStorageService {
  late final FlutterSecureStorage storage;

  SecureStorageService() {
    storage = const FlutterSecureStorage();
  }

  @override
  Future<void> write({required String key, String? value}) async {
    try {
      await storage.write(key: key, value: value);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> delete({required String key}) async {
    try {
      await storage.delete(key: key);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<String?> read({required String key}) async {
    try {
      return await storage.read(key: key);
    } catch (_) {
      rethrow;
    }
  }
}