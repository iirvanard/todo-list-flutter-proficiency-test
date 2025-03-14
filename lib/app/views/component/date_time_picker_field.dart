import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_iirvanard/app/lib/colors.dart';
import 'package:todo_iirvanard/app/views/component/custom_text_field.dart';

class DateTimePickerField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final VoidCallback onTap;

  const DateTimePickerField({
    Key? key,
    required this.controller,
    required this.label,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AbsorbPointer(
        child: CustomTextField(
          controller: controller,
          label: label,
          readOnly: true,
        ),
      ),
    );
  }
}
