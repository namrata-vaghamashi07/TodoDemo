import 'package:flutter/material.dart';
import 'package:todo_demo/utils/color_constants/color_constants.dart';
import 'package:todo_demo/utils/widgets/todo_text_widget.dart';

class TodoElevatedButton extends StatelessWidget {
  final String title;
  final void Function()? onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? borderColor;
  final bool? isLoading;

  const TodoElevatedButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.fontSize,
    this.fontWeight,
    this.borderColor,
    this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(
              color: borderColor ?? ColorConstants.blackColor,
              width: 1,
            ),
          ),
        ),
        onPressed: onPressed,
        child: isLoading ?? false
            ? const CircularProgressIndicator(color: Colors.white)
            : TodoTextWidget(
                title: title,
                color: textColor,
                fontSize: fontSize,
                fontWeight: fontWeight,
              ),
      ),
    );
  }
}
