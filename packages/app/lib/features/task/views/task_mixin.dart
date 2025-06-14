import 'package:flutter/material.dart';

mixin TaskFormMixin<T extends StatefulWidget> on State<T> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  Widget buildTaskForm() {
    return Form(
      key: formKey,
      child: Column(
        children: [
          TextFormField(
            controller: titleController,
            decoration: InputDecoration(
              labelText: 'Task Title',
              border: OutlineInputBorder(),
            ),
            validator:
                (value) =>
                    (value == null || value.trim().isEmpty)
                        ? 'Please enter a task title'
                        : null,
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: descriptionController,
            decoration: InputDecoration(
              labelText: 'Description',
              border: OutlineInputBorder(),
            ),
            maxLines: 4,
            validator:
                (value) =>
                    (value == null || value.trim().isEmpty)
                        ? 'Please enter a description'
                        : null,
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  bool validateForm() {
    return formKey.currentState?.validate() ?? false;
  }

  void disposeFormControllers() {
    titleController.dispose();
    descriptionController.dispose();
  }
}
