import 'package:flutter/material.dart';
import 'package:todo_demo/utils/color_constants/color_constants.dart';

class TodoTextWidget extends StatelessWidget {
  const TodoTextWidget(
      {super.key,
      required this.title,
      this.fontSize,
      this.fontWeight,
      this.color,
      this.maxLines,
      this.overflow});
  final String title;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final int? maxLines;
  final TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      maxLines: maxLines,
      overflow: overflow,
      style: TextStyle(
          fontSize: fontSize ?? 12,
          fontWeight: fontWeight ?? FontWeight.w400,
          color: color ?? ColorConstants.blackColor),
    );
  }
}
