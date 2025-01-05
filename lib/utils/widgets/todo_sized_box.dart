import 'package:flutter/material.dart';

class TodoSizedBox extends StatelessWidget {
  final double? height;
  final double? width;
  const TodoSizedBox({super.key, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
    );
  }
}
