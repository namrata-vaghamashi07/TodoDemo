import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_demo/screens/todo_list_page.dart';
import 'package:todo_demo/utils/binding/binding.dart';
import 'package:todo_demo/utils/color_constants/color_constants.dart';
import 'package:todo_demo/utils/string_constants/string_constants.dart';
import 'package:todo_demo/utils/widgets/todo_elevated_button.dart';
import 'package:todo_demo/utils/widgets/todo_sized_box.dart';
import 'package:todo_demo/utils/widgets/todo_textfield.dart';
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
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TodoTextFormField(
                controller: titleController,
                labelText: StringConstants.title,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return StringConstants.titleErrorMsg;
                  }
                  return null;
                },
              ),

              const TodoSizedBox(height: 20),
              TodoTextFormField(
                controller: descriptionController,
                labelText: StringConstants.description,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return StringConstants.descriptionErrorMsg;
                  }
                  return null;
                },
              ),

              const TodoSizedBox(height: 20),

              // Time field (MM:SS)
              TodoTextFormField(
                controller: timeController,
                labelText: StringConstants.timerLable,
                helperText: StringConstants.max5min,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return StringConstants.enterTimeMsg;
                  }
                  // Validate the MM:SS format
                  final timeParts = value.split(":");
                  if (timeParts.length != 2) {
                    return StringConstants.invalidTimeMsg;
                  }

                  final minutes = int.tryParse(timeParts[0]);
                  final seconds = int.tryParse(timeParts[1]);

                  if (minutes == null || seconds == null) {
                    return StringConstants.invalidNumber;
                  }

                  if (minutes < 0 || minutes > 5) {
                    return StringConstants.minuteMsg;
                  }

                  if (seconds < 0 || seconds >= 60) {
                    return StringConstants.secoundMsg;
                  }

                  return null;
                },
              ),
              const TodoSizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TodoElevatedButton(
                    title: StringConstants.cancel,
                    onPressed: () => Get.back(),
                    fontSize: 16,
                    backgroundColor: ColorConstants.whiteColor,
                    fontWeight: FontWeight.w500,
                    textColor: ColorConstants.blackColor.withOpacity(0.8),
                  ),
                  const TodoSizedBox(width: 10),
                  TodoElevatedButton(
                    title: widget.todo != null
                        ? StringConstants.update
                        : StringConstants.save,
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
                            status: widget.todo?.status ?? StringConstants.todo,
                            timer: totalSeconds,
                          );
                          kTodoController.addTodo(newTodo);
                        } else {
                          // Update todo item
                          final Todo newTodo = Todo(
                            id: widget.todo!.id,
                            title: title,
                            description: description,
                            status: widget.todo?.status ?? StringConstants.todo,
                            timer: totalSeconds,
                          );
                          kTodoController.updateTodo(newTodo);
                        }
                        Get.offAll(() => const TodoListPage());
                      }
                    },
                    fontSize: 16,
                    borderColor: ColorConstants.blueColor,
                    backgroundColor: ColorConstants.blueColor,
                    textColor: ColorConstants.whiteColor,
                    fontWeight: FontWeight.w500,
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
