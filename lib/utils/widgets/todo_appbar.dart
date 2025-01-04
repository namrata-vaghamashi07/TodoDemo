import 'package:flutter/material.dart';
import 'package:todo_demo/utils/color_constants/color_constants.dart';
import 'package:todo_demo/utils/widgets/todo_text_widget.dart';

class TodoAppbar extends StatelessWidget implements PreferredSizeWidget {
  const TodoAppbar({super.key, required this.title, this.leading});
  final String title;
  final Widget? leading;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: ColorConstants.blueColor,
      automaticallyImplyLeading: false,
      title: TodoTextWidget(
        title: title,
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: ColorConstants.whiteColor,
      ),
      leading: leading,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
