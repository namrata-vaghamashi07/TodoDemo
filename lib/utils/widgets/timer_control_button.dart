import 'package:flutter/material.dart';
import 'package:todo_demo/utils/color_constants/color_constants.dart';

class TimerControlButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool valueKey;
  final IconData icon;

  const TimerControlButton({
    super.key,
    required this.onPressed,
    required this.valueKey,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: ColorConstants.greyColor.withOpacity(0.5),
        ),
        child: IconButton(
          key: ValueKey(valueKey),
          icon: Icon(
            icon,
            size: 30,
            color: ColorConstants.blackColor,
          ),
          onPressed: onPressed,
        ),
      ),
    );
  }
}
