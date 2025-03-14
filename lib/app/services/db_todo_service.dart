import 'package:todo_iirvanard/app/services/db_service.dart';
import '../models/todo_model.dart';

class TodoDatabaseService {
  static Future<int> addTodo(Todo todo) async {
    final db = await DatabaseService.database;
    return await db.insert('todos', todo.toMap());
  }

  static Future<int> updateTodo(Todo todo) async {
    final db = await DatabaseService.database;
    return await db.update(
      'todos',
      todo.toMap(),
      where: 'id = ? AND user_id = ?',
      whereArgs: [todo.id, todo.userId],
    );
  }

  static Future<int> deleteTodo(int id, int userId) async {
    final db = await DatabaseService.database;
    return await db.delete(
      'todos',
      where: 'id = ? AND user_id = ?',
      whereArgs: [id, userId],
    );
  }

  static Future<List<Todo>> searchTodos(String keyword, int userId) async {
    final db = await DatabaseService.database;
    List<Map<String, dynamic>> maps = await db.query(
      'todos',
      where: '(title LIKE ? OR description LIKE ?) AND user_id = ?',
      whereArgs: ['%$keyword%', '%$keyword%', userId],
    );
    return maps.map((map) => Todo.fromMap(map)).toList();
  }

  static Future<Todo?> getTodoById(int id, int userId) async {
    final db = await DatabaseService.database;
    List<Map<String, dynamic>> maps = await db.query(
      'todos',
      where: 'id = ? AND user_id = ?',
      whereArgs: [id, userId],
    );
    if (maps.isNotEmpty) {
      return Todo.fromMap(maps.first);
    }
    return null;
  }

  static Future<List<Todo>> getAllTodos(int userId) async {
    final db = await DatabaseService.database;
    List<Map<String, dynamic>> maps = await db.query(
      'todos',
      where: 'user_id = ?',
      whereArgs: [userId],
    );
    return maps.map((map) => Todo.fromMap(map)).toList();
  }
}
