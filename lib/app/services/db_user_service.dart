import 'package:todo_iirvanard/app/services/db_service.dart';
import '../models/user_model.dart';

class UserDatabaseService {
  static Future<int> registerUser(User user) async {
    final db = await DatabaseService.database;
    return await db.insert('users', user.toMap());
  }

  static Future<User?> getUserByUsername(String username) async {
    final db = await DatabaseService.database;
    List<Map<String, dynamic>> result = await db.query(
      'users',
      where: 'username = ?',
      whereArgs: [username],
    );
    return result.isNotEmpty ? User.fromMap(result.first) : null;
  }
}
