import 'package:flutter/material.dart';
import 'package:todo_demo/utils/color_constants/color_constants.dart';

class TodoTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final String? labelText;
  final String? helperText;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final bool obscureText;
  final Function(String)? onChanged;
  final String? hintText;
  final Widget? prefixIcon;

  const TodoTextFormField({
    super.key,
    this.controller,
    this.labelText,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.helperText,
    this.onChanged,
    this.hintText,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(8),
          labelText: labelText,
          helperText: helperText,
          hintText: hintText,
          prefixIcon: prefixIcon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          hintStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: ColorConstants.greyColor)),
      onChanged: onChanged,
      validator: validator,
      keyboardType: keyboardType,
      obscureText: obscureText,
    );
  }
}
