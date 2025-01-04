import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_demo/data/todo_model.dart';
import 'package:todo_demo/screens/add_edit_todo_bottomsheet.dart';
import 'package:todo_demo/utils/binding/binding.dart';
import 'package:todo_demo/utils/color_constants/color_constants.dart';
import 'package:todo_demo/utils/string_constants/string_constants.dart';
import 'package:todo_demo/utils/widgets/todo_appbar.dart';
import 'package:todo_demo/utils/widgets/todo_text_widget.dart';

class TodoDetailPage extends StatefulWidget {
  final Todo todo;

  const TodoDetailPage({super.key, required this.todo});

  @override
  State<TodoDetailPage> createState() => _TodoDetailPageState();
}

class _TodoDetailPageState extends State<TodoDetailPage> {
  @override
  void initState() {
    kTodoController.initTodoValueSet(widget.todo);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.whiteColor,
      appBar: TodoAppbar(
        title: StringConstants.todoDetail,
        leading: IconButton(
            onPressed: () => Get.back(),
            icon:
                const Icon(Icons.arrow_back, color: ColorConstants.whiteColor)),
      ),
      body: Obx(
        () => Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: ColorConstants.whiteColor,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: ColorConstants.greyColor.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: const Offset(0, 4), // changes position of shadow
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TodoTextWidget(
                      title: StringConstants.title.toUpperCase(),
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: ColorConstants.blackColor,
                    ),
                    TodoTextWidget(
                      title: widget.todo.title.toUpperCase(),
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: ColorConstants.greyColor,
                    ),
                    const SizedBox(height: 10),
                    TodoTextWidget(
                      title: StringConstants.description.toUpperCase(),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: ColorConstants.blackColor,
                    ),
                    TodoTextWidget(
                      title: widget.todo.description,
                      fontSize: 18,
                      color: ColorConstants.greyColor,
                    ),
                    const SizedBox(height: 10),
                    TodoTextWidget(
                      title: StringConstants.status.toUpperCase(),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: ColorConstants.blackColor,
                    ),
                    TodoTextWidget(
                      title: kTodoController.todoStatusUpdate.value,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: ColorConstants.greyColor,
                    ),
                    const SizedBox(height: 10),
                    TodoTextWidget(
                      title: StringConstants.timer.toUpperCase(),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: ColorConstants.blackColor,
                    ),
                    TodoTextWidget(
                      title: kTodoController.timerFormat(
                          kTodoController.minutes.value,
                          kTodoController.seconds.value),
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: ColorConstants.greyColor,
                    ),
                    const SizedBox(height: 20),
                    widget.todo.status == 'Done'
                        ? const SizedBox()
                        : _buildTimerControls(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorConstants.blueColor,
        child: const Icon(
          Icons.edit,
          color: ColorConstants.whiteColor,
        ),
        onPressed: () => showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (_) => Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: AddEditTodoBottomSheet(todo: widget.todo),
          ),
        ),
      ),
    );
  }

  Widget _buildTimerControls() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: ColorConstants.greyColor.withOpacity(0.5)),
            child: IconButton(
              key: ValueKey(kTodoController.isRunning.value),
              icon: Icon(
                (widget.todo.status == 'In-Progress' &&
                        kTodoController.isRunning.value &&
                        !kTodoController.isPaused.value)
                    ? Icons.pause
                    : Icons.play_arrow,
                size: 30,
                color: ColorConstants.blackColor,
              ),
              onPressed: () {
                if (kTodoController.isRunning.value) {
                  kTodoController.pauseTimer(widget.todo.id!);
                } else if (kTodoController.isPaused.value) {
                  kTodoController.resumeTimer(widget.todo.id!);
                } else {
                  kTodoController.startTimer(
                      widget.todo.timer, widget.todo.id!);
                }
              },
            ),
          ),
        ),
        const SizedBox(width: 10),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: ColorConstants.greyColor.withOpacity(0.5)),
            child: IconButton(
              key: ValueKey(kTodoController.isRunning.value),
              icon: const Icon(
                Icons.stop,
                size: 30,
                color: ColorConstants.blackColor,
              ),
              onPressed: () {
                kTodoController.stopTimer(widget.todo.id!);
              },
            ),
          ),
        ),
      ],
    );
  }
}
