import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_demo/screens/todo_details_page.dart';
import 'package:todo_demo/utils/binding/binding.dart';
import 'package:todo_demo/utils/color_constants/color_constants.dart';
import 'package:todo_demo/utils/string_constants/string_constants.dart';
import 'package:todo_demo/utils/widgets/add_bottom_sheet.dart';
import 'package:todo_demo/utils/widgets/todo_appbar.dart';
import 'package:todo_demo/utils/widgets/todo_chip_status.dart';
import 'package:todo_demo/utils/widgets/todo_sized_box.dart';
import 'package:todo_demo/utils/widgets/todo_text_widget.dart';
import 'package:todo_demo/utils/widgets/todo_textfield.dart';

class TodoListPage extends StatelessWidget {
  const TodoListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: ColorConstants.whiteColor,
        appBar: const TodoAppbar(
          title: StringConstants.todoList,
        ),
        body: Obx(() {
          return SingleChildScrollView(
            child: Column(
              children: [
                const TodoSizedBox(height: 20),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: TodoTextFormField(
                        onChanged: (query) {
                          kTodoController.searchQuery.value = query;
                          kTodoController.loadTodos();
                        },
                        hintText: StringConstants.searchText,
                        prefixIcon: const Icon(Icons.search))),
                kTodoController.isLoading.value
                    ? const Center(child: CircularProgressIndicator())
                    : kTodoController.todoList.isEmpty
                        ? const Center(
                            child: TodoTextWidget(
                            title: StringConstants.noTodoData,
                            fontSize: 14,
                          ))
                        : ListView.separated(
                            separatorBuilder: (context, index) =>
                                const TodoSizedBox(height: 4),
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: kTodoController.todoList.length,
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            itemBuilder: (context, index) {
                              final todo = kTodoController.todoList[index];
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Card(
                                  color: ColorConstants.whiteColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      side: BorderSide(
                                          color: ColorConstants.greyColor
                                              .withOpacity(0.2),
                                          width: 1)),
                                  elevation: 3,
                                  child: ListTile(
                                    enabled: true,
                                    onTap: () {
                                      Get.to(TodoDetailPage(
                                        todo: todo,
                                      ));
                                    },
                                    title: TodoTextWidget(
                                        title: todo.title,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600),
                                    subtitle: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TodoTextWidget(
                                            title: todo.description,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400),
                                        Row(
                                          children: [
                                            TodoTextWidget(
                                                title: todo.timer,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400),
                                            const TodoSizedBox(width: 10),
                                            TodoChipStatus(
                                                labelPadding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 0,
                                                        horizontal: 8),
                                                backgroundColor:
                                                    ColorConstants.whiteColor,
                                                label: todo.status,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                                textColor:
                                                    ColorConstants.greyColor),
                                          ],
                                        ),
                                      ],
                                    ),
                                    trailing: IconButton(
                                      icon: const Icon(Icons.delete_outline),
                                      onPressed: () {
                                        kTodoController.deleteTodo(todo.id!);
                                      },
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
              ],
            ),
          );
        }),
        floatingActionButton: const FloatingActionButtonWithBottomSheet());
  }
}
