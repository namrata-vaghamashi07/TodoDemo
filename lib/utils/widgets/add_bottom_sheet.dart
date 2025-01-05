import 'package:flutter/material.dart';
import 'package:todo_demo/data/todo_model.dart';
import 'package:todo_demo/screens/add_edit_todo_bottomsheet.dart';
import 'package:todo_demo/utils/color_constants/color_constants.dart';

class FloatingActionButtonWithBottomSheet extends StatelessWidget {
  final Todo? todo;

  const FloatingActionButtonWithBottomSheet({
    super.key,
    this.todo,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: ColorConstants.blueColor,
      child: Icon(
        todo == null ? Icons.add : Icons.edit,
        color: ColorConstants.whiteColor,
      ),
      onPressed: () => showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: ColorConstants.whiteColor,
        builder: (_) => Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: AddEditTodoBottomSheet(todo: todo),
        ),
      ),
    );
  }
}
