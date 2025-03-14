import 'package:get/get.dart';
import 'package:todo_iirvanard/app/services/db_todo_service.dart';
import '../models/todo_model.dart';

class TodoController extends GetxController {
  var todos = <Todo>[].obs;
  var selectedTodos = <Todo>[].obs;

  Future<void> fetchTodos(int userId) async {
    try {
      todos.value = await TodoDatabaseService.getAllTodos(userId);
    } catch (e) {
      print("Error fetching todos: \$e");
    }
  }

  Future<bool> updateTodo(Todo todo) async {
    try {
      await TodoDatabaseService.updateTodo(todo);
      int index = todos.indexWhere((t) => t.id == todo.id);
      if (index != -1) {
        todos[index] = todo;
        update(); // Memperbarui state agar UI ter-refresh
      }
      return true;
    } catch (e) {
      print("Error updating todo: \$e");
      return false;
    }
  }

  Future<void> addTodo(Todo todo) async {
    try {
      int id = await TodoDatabaseService.addTodo(todo);
      if (id > 0) {
        todo.id = id;
        todos.add(todo);
      }
    } catch (e) {
      print("Error adding todo: \$e");
    }
  }

  void searchTodos(String keyword, int userId) async {
    try {
      todos.value =
          keyword.isEmpty
              ? await TodoDatabaseService.getAllTodos(userId)
              : await TodoDatabaseService.searchTodos(keyword, userId);
    } catch (e) {
      print("Error searching todos: \$e");
    }
  }

  void toggleSelection(Todo todo) {
    if (selectedTodos.any((t) => t.id == todo.id)) {
      selectedTodos.removeWhere((t) => t.id == todo.id);
    } else {
      selectedTodos.add(todo);
    }
    update(); // Pastikan UI diperbarui
  }

  void selectAll() {
    selectedTodos.assignAll(todos);
    update();
  }

  void deselectAll() {
    selectedTodos.clear();
    update();
  }

  Future<void> deleteSelectedTodos() async {
    try {
      for (var todo in selectedTodos) {
        await deleteTodo(todo.id!, todo.userId);
      }
      selectedTodos.clear();
      update();
    } catch (e) {
      print("Error deleting selected todos: \$e");
    }
  }

  Future<Todo?> getTodoById(int id, int userId) async {
    try {
      return await TodoDatabaseService.getTodoById(id, userId);
    } catch (e) {
      print("Error fetching todo: \$e");
      return null;
    }
  }

  Future<void> deleteTodo(int id, int userId) async {
    try {
      await TodoDatabaseService.deleteTodo(id, userId);
      todos.removeWhere((todo) => todo.id == id);
    } catch (e) {
      print("Error deleting todo: \$e");
    }
  }
}
