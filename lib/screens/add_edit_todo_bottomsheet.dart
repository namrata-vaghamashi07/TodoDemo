import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_demo/utils/binding/binding.dart';
import 'package:todo_demo/utils/widgets/todo_text_widget.dart';
import '../data/todo_model.dart';

class AddEditTodoBottomSheet extends StatefulWidget {
  final Todo? todo;

  const AddEditTodoBottomSheet({super.key, this.todo});

  @override
  AddEditTodoBottomSheetState createState() => AddEditTodoBottomSheetState();
}

class AddEditTodoBottomSheetState extends State<AddEditTodoBottomSheet> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController timeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.todo != null) {
      titleController.text = widget.todo!.title;
      descriptionController.text = widget.todo!.description;
      timeController.text = widget.todo!.timer.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),

              // Time field (MM:SS)
              TextFormField(
                controller: timeController,
                // keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Time (MM:SS)',
                  helperText: 'Max: 5 minutes',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a time';
                  }
                  // Validate the MM:SS format
                  final timeParts = value.split(":");
                  if (timeParts.length != 2) {
                    return 'Invalid time format. Use MM:SS';
                  }

                  final minutes = int.tryParse(timeParts[0]);
                  final seconds = int.tryParse(timeParts[1]);

                  if (minutes == null || seconds == null) {
                    return 'Invalid number format in time';
                  }

                  if (minutes < 0 || minutes > 5) {
                    return 'Minutes should be between 0 and 5';
                  }

                  if (seconds < 0 || seconds >= 60) {
                    return 'Seconds should be between 0 and 59';
                  }

                  return null;
                },
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey),
                      onPressed: () => Get.back(), // Close without saving
                      child: const TodoTextWidget(
                        title: 'Cancel',
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          final String title = titleController.text.trim();
                          final String description =
                              descriptionController.text.trim();

                          // Convert minutes to Duration object
                          final timeString = timeController.text.trim();
                          final timeParts = timeString.split(":");
                          final minutes = int.parse(timeParts[0]);
                          final seconds = int.parse(timeParts[1]);
                          var totalSeconds =
                              kTodoController.timerFormat(minutes, seconds);

                          if (widget.todo == null) {
                            // Add a new todo item
                            final Todo newTodo = Todo(
                              title: title,
                              description: description,
                              status: widget.todo?.status ?? 'TODO',
                              timer: totalSeconds,
                            );
                            kTodoController.addTodo(newTodo);
                          } else {
                            // Update todo item
                            final Todo newTodo = Todo(
                              id: widget.todo!.id,
                              title: title,
                              description: description,
                              status: widget.todo?.status ?? 'TODO',
                              timer: totalSeconds,
                            );
                            kTodoController.updateTodo(newTodo);
                          }
                          Get.back();
                        }
                      },
                      child: TodoTextWidget(
                        title: widget.todo != null ? 'Update' : 'Save',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
