import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_iirvanard/app/lib/colors.dart';
import 'package:todo_iirvanard/app/views/component/show_dialog_field.dart';
import 'package:todo_iirvanard/app/views/detail_screen.dart';
import '../controllers/auth_controller.dart';
import '../controllers/todo_controller.dart';
import '../models/todo_model.dart';
import 'onboarding_screen.dart';

class HomeScreen extends StatelessWidget {
  final AuthController authController = Get.find();
  final TodoController todoController = Get.put(TodoController());
  final TextEditingController searchController = TextEditingController();

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (!authController.isLoggedIn.value) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Get.offAll(() => OnboardingScreen());
        });
        return Scaffold(body: Center(child: CircularProgressIndicator()));
      }

      final int? userId = authController.loggedInUser.value?.id;

      if (userId != null) {
        // Pindahkan fetchTodos ke dalam TodoController untuk mencegah pemanggilan berulang
        todoController.fetchTodos(userId);
      }

      return Scaffold(
        appBar: AppBar(
          title: Text(
            "Home",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          backgroundColor: AppColors.main,
          iconTheme: IconThemeData(color: Colors.white),
          actions: [
            Obx(() {
              if (todoController.selectedTodos.isNotEmpty) {
                return IconButton(
                  icon: Icon(Icons.select_all, color: Colors.white),
                  onPressed: () {
                    if (todoController.selectedTodos.length ==
                        todoController.todos.length) {
                      todoController.deselectAll();
                    } else {
                      todoController.selectAll();
                    }
                  },
                );
              }
              return SizedBox.shrink();
            }),
            IconButton(
              icon: Icon(Icons.logout, color: Colors.white),
              onPressed: () => authController.logout(),
            ),
          ],
        ),
        backgroundColor: AppColors.main,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                color: AppColors.secondary,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      hintText: "Cari tugas...",
                      prefixIcon: Icon(Icons.search, color: AppColors.main),
                      border: InputBorder.none,
                      filled: true,
                      fillColor: AppColors.secondary,
                      contentPadding: EdgeInsets.symmetric(vertical: 12),
                    ),
                    onChanged:
                        (value) => todoController.searchTodos(value, userId!),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Obx(() {
                if (todoController.todos.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.task_alt, color: Colors.white, size: 50),
                        SizedBox(height: 10),
                        Text(
                          "Tidak ada tugas ditemukan",
                          textAlign:
                              TextAlign.center, // Pastikan teks ada di tengah
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ],
                    ),
                  );
                }

                return GetBuilder<TodoController>(
                  builder: (controller) {
                    return ListView.builder(
                      itemCount: todoController.todos.length,
                      itemBuilder: (context, index) {
                        Todo todo = todoController.todos[index];
                        bool isSelected = todoController.selectedTodos.any(
                          (t) => t.id == todo.id,
                        );

                        return GestureDetector(
                          onLongPress:
                              () => todoController.toggleSelection(todo),
                          onTap: () {
                            if (todoController.selectedTodos.isNotEmpty) {
                              todoController.toggleSelection(todo);
                            } else {
                              Get.to(
                                () => DetailScreen(
                                  todoID: todo.id!,
                                  userID: userId!,
                                  // onUpdate: (updatedTodo) {
                                  //   // Handle hasil update di sini, misalnya setState untuk memperbarui daftar todo
                                  // },
                                ),
                              );
                            }
                          },
                          child: Card(
                            elevation: 4,
                            margin: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            color:
                                isSelected
                                    ? AppColors.accent.withOpacity(
                                      0.1,
                                    ) // Gunakan opacity yang lebih tinggi
                                    : AppColors.secondary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                              side:
                                  isSelected
                                      ? BorderSide(
                                        color: AppColors.accent,
                                        width: 2,
                                      ) // Tambahkan border saat di-select
                                      : BorderSide.none,
                            ),
                            child: ListTile(
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                              title: Text(
                                todo.title,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color:
                                      isSelected
                                          ? Colors.white
                                          : AppColors
                                              .textPrimary, // Ubah warna teks saat di-select
                                ),
                              ),
                              subtitle: Text(
                                todo.description,
                                style: TextStyle(
                                  color:
                                      isSelected
                                          ? Colors.white.withOpacity(0.8)
                                          : AppColors
                                              .textSecondary, // Ubah warna teks saat di-select
                                ),
                              ),
                              trailing: Icon(
                                Icons.chevron_right,
                                color:
                                    isSelected
                                        ? Colors.white
                                        : AppColors
                                            .main, // Ubah warna ikon saat di-select
                                size: 24,
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              }),
            ),
          ],
        ),
        floatingActionButton: Obx(() {
          if (todoController.selectedTodos.isNotEmpty) {
            return FloatingActionButton(
              backgroundColor: Colors.red,
              child: Icon(Icons.delete, color: Colors.white),
              onPressed: () => todoController.deleteSelectedTodos(),
            );
          }
          return FloatingActionButton(
            backgroundColor: AppColors.accent,
            child: Icon(Icons.add, color: Colors.white),
            onPressed: () {
              TodoAddDialog(context, (title, description, deadline) {
                todoController.addTodo(
                  Todo(
                    title: title,
                    description: description,
                    isCompleted: false,
                    userId: userId!,
                    deadline: deadline,
                  ),
                  // Menutup halaman saat tombol ditekan
                );
              });
            },
          );
        }),
      );
    });
  }
}
