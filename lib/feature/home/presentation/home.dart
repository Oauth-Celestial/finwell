import 'package:finwell/core/extensions/build_context.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.currentTheme!.backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: context.currentTheme!.backgroundColor,
        title: Text(
          "Finwell",
          style: TextStyle(
              color: context.currentTheme!.textColor,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
