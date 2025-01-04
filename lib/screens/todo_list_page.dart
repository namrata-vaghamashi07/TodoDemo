import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:todo_demo/screens/add_edit_todo_bottomsheet.dart';
import 'package:todo_demo/screens/todo_details_page.dart';
import 'package:todo_demo/utils/binding/binding.dart';
import 'package:todo_demo/utils/widgets/todo_appbar.dart';
import 'package:todo_demo/utils/widgets/todo_text_widget.dart';

class TodoListPage extends StatelessWidget {
  const TodoListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: const TodoAppbar(title: 'Todo List'),
      body: Obx(() {
        return kTodoController.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : kTodoController.todoList.isEmpty
                ? const Center(
                    child: TodoTextWidget(
                    title: 'No Todos Found',
                    fontSize: 14,
                  ))
                : ListView.builder(
                    itemCount: kTodoController.todoList.length,
                    itemBuilder: (context, index) {
                      final todo = kTodoController.todoList[index];

                      return ListTile(
                        enabled: true,
                        onTap: () {
                          Get.to(TodoDetailPage(
                            todo: todo,
                          ));
                        },
                        title: Text(todo.title),
                        subtitle: Text('${todo.timer}  - ${todo.status}'),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            kTodoController.deleteTodo(todo.id!);
                          },
                        ),
                      );
                    },
                  );
      }),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (_) => Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: const AddEditTodoBottomSheet(),
          ),
        ),
      ),
    );
  }
}
