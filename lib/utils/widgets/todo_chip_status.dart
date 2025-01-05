import 'package:flutter/material.dart';
import 'package:todo_demo/utils/widgets/todo_text_widget.dart';

class TodoChipStatus extends StatelessWidget {
  final String label;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? textColor;
  final Color? backgroundColor;
  final EdgeInsets? labelPadding;
  final double? borderRadius;

  const TodoChipStatus({
    super.key,
    required this.label,
    this.fontSize,
    this.fontWeight,
    this.textColor,
    this.backgroundColor,
    this.labelPadding,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: TodoTextWidget(
        title: label,
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: textColor,
      ),
      elevation: 1,
      padding: EdgeInsets.zero,
      backgroundColor: backgroundColor,
      labelPadding: labelPadding,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
