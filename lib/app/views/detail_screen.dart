import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_iirvanard/app/views/component/custom_text_field.dart';
import 'package:todo_iirvanard/app/views/component/date_time_picker_field.dart';
import 'package:todo_iirvanard/app/views/home_screen.dart';
import '../models/todo_model.dart';
import '../controllers/todo_controller.dart';
import '../lib/colors.dart';

class DetailScreen extends StatelessWidget {
  final int todoID;
  final int userID;

  DetailScreen({Key? key, required this.todoID, required this.userID})
    : super(key: key);

  final TodoController todoController = Get.find<TodoController>();
  final Rx<Todo?> todo = Rx<Todo?>(null);

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final dateController = TextEditingController();
  final timeController = TextEditingController();
  final isCompleted = false.obs;
  final selectedDateTime = DateTime.now().obs;

  @override
  Widget build(BuildContext context) {
    _fetchTodo();

    return Scaffold(
      appBar: _buildAppBar(),
      backgroundColor: AppColors.main,
      body: Obx(
        () =>
            todo.value == null
                ? const Center(child: CircularProgressIndicator())
                : _buildBody(),
      ),
      floatingActionButton: _buildFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text(
        "Detail Todo",
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      backgroundColor: AppColors.main,
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextField(controller: titleController, label: "Title"),
          CustomTextField(
            controller: descriptionController,
            label: "Description",
            maxLines: 3,
          ),
          Row(
            children: [
              Expanded(
                child: DateTimePickerField(
                  controller: dateController,
                  label: "Date",
                  onTap: _selectDate,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: DateTimePickerField(
                  controller: timeController,
                  label: "Time",
                  onTap: _selectTime,
                ),
              ),
            ],
          ),
          _buildStatusSwitch(),
          const SizedBox(height: 80),
        ],
      ),
    );
  }

  Widget _buildFloatingActionButton() {
    return FloatingActionButton.extended(
      onPressed: _updateTodo,
      label: const Text(
        "Update Todo",
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      icon: const Icon(Icons.edit, color: Colors.white),
      backgroundColor: AppColors.accent,
    );
  }

  Future<void> _fetchTodo() async {
    Todo? fetchedTodo = await todoController.getTodoById(todoID, userID);
    if (fetchedTodo != null) {
      todo.value = fetchedTodo;
      titleController.text = fetchedTodo.title;
      descriptionController.text = fetchedTodo.description;
      selectedDateTime.value = fetchedTodo.deadline;
      isCompleted.value = fetchedTodo.isCompleted;
      _updateDateTimeFields();
    }
  }

  Widget _buildStatusSwitch() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: AppColors.secondary,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Obx(
          () => SwitchListTile(
            title: Text(
              "Status",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            value: isCompleted.value,
            onChanged: (value) => isCompleted.value = value,
            activeColor: AppColors.accent,
          ),
        ),
      ),
    );
  }

  void _updateDateTimeFields() {
    dateController.text =
        "${selectedDateTime.value.year}-${selectedDateTime.value.month.toString().padLeft(2, '0')}-${selectedDateTime.value.day.toString().padLeft(2, '0')}";
    final time = TimeOfDay.fromDateTime(selectedDateTime.value);
    timeController.text =
        "${time.hourOfPeriod}:${time.minute.toString().padLeft(2, '0')} ${time.period == DayPeriod.am ? 'AM' : 'PM'}";
  }

  Future<void> _selectDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: Get.context!,
      initialDate: selectedDateTime.value,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      selectedDateTime.value = DateTime(
        pickedDate.year,
        pickedDate.month,
        pickedDate.day,
        selectedDateTime.value.hour,
        selectedDateTime.value.minute,
      );
      _updateDateTimeFields();
    }
  }

  Future<void> _selectTime() async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: Get.context!,
      initialTime: TimeOfDay.fromDateTime(selectedDateTime.value),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: child!,
        );
      },
    );

    if (pickedTime != null) {
      selectedDateTime.value = DateTime(
        selectedDateTime.value.year,
        selectedDateTime.value.month,
        selectedDateTime.value.day,
        pickedTime.hour,
        pickedTime.minute,
      );
      _updateDateTimeFields();
    }
  }

  void _updateTodo() async {
    Todo updatedTodo = Todo(
      id: todoID,
      userId: userID,
      title: titleController.text,
      description: descriptionController.text,
      deadline: selectedDateTime.value,
      isCompleted: isCompleted.value,
    );

    bool success = await todoController.updateTodo(updatedTodo);
    if (success) Get.offAll(() => HomeScreen());
  }
}
