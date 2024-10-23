import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:finwell/core/extensions/build_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HorizontalCalendar extends StatefulWidget {
  DateTime? startDate;
  DateTime? initialFocusDate;
  Function(DateTime) onDateChange;

  HorizontalCalendar({super.key, this.startDate, required this.onDateChange});

  @override
  State<HorizontalCalendar> createState() => _HorizontalCalendarState();
}

class _HorizontalCalendarState extends State<HorizontalCalendar> {
  DateTime? _focusDate;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _focusDate = widget.initialFocusDate ?? DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return EasyInfiniteDateTimeLine(
      showTimelineHeader: false,
      selectionMode: const SelectionMode.autoCenter(),
      firstDate: DateTime(2024),
      focusDate: _focusDate,
      lastDate: DateTime(2024, 12, 31),
      onDateChange: (selectedDate) {
        setState(() {
          widget.onDateChange(selectedDate);
          _focusDate = selectedDate;
        });
      },
      dayProps: const EasyDayProps(
        // You must specify the width in this case.
        width: 80.0,
        // The height is not required in this case.
        height: 80.0,
      ),
      itemBuilder: (
        BuildContext context,
        DateTime date,
        bool isSelected,
        VoidCallback onTap,
      ) {
        return InkResponse(
          // You can use `InkResponse` to make your widget clickable.
          // The `onTap` callback responsible for triggering the `onDateChange`
          // callback and animating to the selected date if the `selectionMode` is
          // SelectionMode.autoCenter() or SelectionMode.alwaysFirst().
          onTap: onTap,
          child: Column(
            children: [
              Flexible(
                child: Text(
                  EasyDateFormatter.shortDayName(date, "en_US"),
                  style: TextStyle(
                    color:
                        isSelected ? context.currentTheme!.buttonColor : null,
                  ),
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              CircleAvatar(
                // use `isSelected` to specify whether the widget is selected or not.
                backgroundColor: isSelected
                    ? context.currentTheme!.buttonColor
                    : context.currentTheme!.buttonColor.withOpacity(0.1),
                radius: 25.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Text(
                        date.day.toString(),
                        style: TextStyle(
                          color: isSelected ? Colors.white : null,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
