import 'package:finwell/core/extensions/build_context.dart';
import 'package:finwell/core/widgets/horizontal_calendar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.currentTheme!.backgroundColor,
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromRGBO(82, 170, 94, 1.0),
        tooltip: 'Increment',
        onPressed: () {},
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
      body: Column(
        children: [
          HorizontalCalendar(
            onDateChange: (selectedDate) {},
          )
        ],
      ),
    );
  }
}
