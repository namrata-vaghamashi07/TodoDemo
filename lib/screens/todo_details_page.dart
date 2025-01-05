import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_demo/data/todo_model.dart';
import 'package:todo_demo/utils/binding/binding.dart';
import 'package:todo_demo/utils/color_constants/color_constants.dart';
import 'package:todo_demo/utils/string_constants/string_constants.dart';
import 'package:todo_demo/utils/widgets/add_bottom_sheet.dart';
import 'package:todo_demo/utils/widgets/timer_control_button.dart';
import 'package:todo_demo/utils/widgets/todo_appbar.dart';
import 'package:todo_demo/utils/widgets/todo_chip_status.dart';
import 'package:todo_demo/utils/widgets/todo_sized_box.dart';
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
              icon: const Icon(Icons.arrow_back,
                  color: ColorConstants.whiteColor)),
        ),
        body: Padding(
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
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: ColorConstants.blackColor,
                    ),
                    const TodoSizedBox(width: 5),
                    TodoTextWidget(
                      title: widget.todo.title.toUpperCase(),
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: ColorConstants.greyColor,
                    ),
                    const TodoSizedBox(height: 20),
                    TodoTextWidget(
                      title: StringConstants.description.toUpperCase(),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: ColorConstants.blackColor,
                    ),
                    const TodoSizedBox(width: 5),
                    TodoTextWidget(
                      title: widget.todo.description,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: ColorConstants.greyColor,
                    ),
                    const TodoSizedBox(height: 20),
                    TodoTextWidget(
                      title: StringConstants.status.toUpperCase(),
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: ColorConstants.blackColor,
                    ),
                    const TodoSizedBox(width: 10),
                    Obx(
                      () => TodoChipStatus(
                          backgroundColor: ColorConstants.whiteColor,
                          label: kTodoController.todoStatusUpdate.value,
                          labelPadding: const EdgeInsets.symmetric(
                              vertical: 0, horizontal: 8),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          textColor: ColorConstants.greyColor),
                    ),
                    const TodoSizedBox(height: 20),
                    TodoTextWidget(
                      title: StringConstants.timer.toUpperCase(),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: ColorConstants.blackColor,
                    ),
                    const TodoSizedBox(width: 5),
                    Obx(
                      () => TodoTextWidget(
                        title: kTodoController.timerFormat(
                            kTodoController.minutes.value,
                            kTodoController.seconds.value),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: ColorConstants.greyColor,
                      ),
                    ),
                    const TodoSizedBox(height: 20),
                    widget.todo.status == StringConstants.done
                        ? const TodoSizedBox()
                        : Obx(() => _buildTimerControls()),
                  ],
                ),
              ),
            ),
          ),
        ),
        floatingActionButton:
            FloatingActionButtonWithBottomSheet(todo: widget.todo));
  }

  Widget _buildTimerControls() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TimerControlButton(
            onPressed: () {
              if (kTodoController.isRunning.value) {
                kTodoController.pauseTimer(widget.todo.id!);
              } else if (kTodoController.isPaused.value) {
                kTodoController.resumeTimer(widget.todo.id!);
              } else {
                kTodoController.startTimer(widget.todo.timer, widget.todo.id!);
              }
            },
            valueKey: kTodoController.isRunning.value,
            icon: (widget.todo.status == StringConstants.inProgress &&
                    kTodoController.isRunning.value &&
                    !kTodoController.isPaused.value)
                ? Icons.pause
                : Icons.play_arrow),
        const TodoSizedBox(width: 10),
        TimerControlButton(
            onPressed: () {
              kTodoController.stopTimer(widget.todo.id!);
            },
            valueKey: kTodoController.isRunning.value,
            icon: Icons.stop),
      ],
    );
  }
}
