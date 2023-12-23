abstract class IStorageService {
  Future<void> write({required String key, String? value});

  Future<void> delete({required String key});

  Future<String?> read({required String key});
}
