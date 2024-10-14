import 'package:finwell/core/extensions/build_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ultimate_extension/ultimate_extension.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final EdgeInsetsGeometry padding;
  final TextInputType keyboardType;
  Function(String)? onChange;
  List<TextInputFormatter>? inputFormatter;

  CustomTextField(
      {super.key,
      required this.controller,
      this.hintText = '',
      this.obscureText = false,
      this.padding = const EdgeInsets.all(16.0),
      this.keyboardType = TextInputType.text,
      this.onChange,
      this.inputFormatter});

  @override
  Widget build(BuildContext context) {
    return TextField(
      inputFormatters: inputFormatter,
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      cursorColor: Colors.white,
      onChanged: onChange,
      style: TextStyle(color: context.currentTheme?.textColor),
      decoration: InputDecoration(
        hintText: hintText,
        contentPadding: padding,
        // Customizing the border
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(color: Colors.grey, width: 1.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide:
              BorderSide(color: ColorHelper.fromHex("#30b481"), width: 2.0),
        ),
        // Optionally add a disabled border
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: Colors.grey.shade300, width: 1.0),
        ),
      ),
    );
  }
}
