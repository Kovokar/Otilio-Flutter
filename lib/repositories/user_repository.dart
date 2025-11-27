import '../models/user.dart';
import '../services/storage_service.dart';

class UserRepository {
  final StorageService _storage = StorageService();

  Future<void> saveUser(User user) => _storage.saveUser(user);
  Future<User?> getUser() => _storage.getUser();
  Future<void> clear() => _storage.clearUser();
}
