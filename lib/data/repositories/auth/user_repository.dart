import 'package:dishdrop_app_projekt/data/models/database_user.dart';

abstract class UserRepository {
  Future<DatabaseUser?> getUser(String uid);
  Future<List<DatabaseUser>> getAllUsers();
}
