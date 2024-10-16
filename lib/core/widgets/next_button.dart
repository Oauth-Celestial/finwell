import 'package:finwell/core/extensions/build_context.dart';
import 'package:flutter/material.dart';

class NextButton extends StatelessWidget {
  VoidCallback? onPressed;
  NextButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
            color: context.currentTheme?.buttonColor,
            borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: Text(
            "Next",
            style: TextStyle(
                color: context.currentTheme?.backgroundColor,
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
