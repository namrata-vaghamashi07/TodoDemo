import 'package:flutter/material.dart';
import 'package:todo_demo/utils/color_constants/color_constants.dart';

class TodoTextWidget extends StatelessWidget {
  const TodoTextWidget(
      {super.key,
      required this.title,
      this.fontSize,
      this.fontWeight,
      this.color});
  final String title;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
          fontSize: fontSize ?? 12,
          fontWeight: fontWeight ?? FontWeight.w400,
          color: color ?? ColorConstants.blackColor),
    );
  }
}
