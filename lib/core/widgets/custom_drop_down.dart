import 'package:finwell/core/extensions/build_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDropDownItem {
  String text;
  Widget icon;
  CustomDropDownItem({
    required this.text,
    required this.icon,
  });
}

class CustomDropdownButton extends StatefulWidget {
  List<CustomDropDownItem> options;
  CustomDropDownItem? initialSelection;
  CustomDropdownButton({Key? key, required this.options, this.initialSelection})
      : super(key: key);
  @override
  _CustomDropdownButtonState createState() => _CustomDropdownButtonState();
}

class _CustomDropdownButtonState extends State<CustomDropdownButton> {
  // Initial selected value
  String dropdownValue = '';

  @override
  void initState() {
    // TODO: implement initState

    dropdownValue = widget.initialSelection == null
        ? widget.options[0].text
        : widget.initialSelection?.text ?? "";
    super.initState();
  }

  // List of options with associated icons

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: DropdownButton<String>(
          value: dropdownValue,
          icon: Icon(
            Icons.arrow_drop_down,
            color: context.currentTheme!.buttonColor,
          ), // Dropdown button icon
          iconSize: 24,
          elevation: 16,
          isExpanded: true,
          style: TextStyle(
              color: context.currentTheme!.textColor, fontSize: 16.sp),
          underline: Container(
            margin: EdgeInsets.only(top: 10),
            height: 2,
            color: context.currentTheme!.buttonColor,
          ),
          onChanged: (String? newValue) {
            setState(() {
              dropdownValue = newValue!;
            });
          },
          items: widget.options
              .map<DropdownMenuItem<String>>((CustomDropDownItem option) {
            return DropdownMenuItem<String>(
              value: option.text,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Row(
                  children: [
                    SizedBox(
                        width: 20.w,
                        height: 20.w,
                        child: option.icon), // Icon for each item
                    SizedBox(width: 8), // Space between icon and text
                    Text(option.text),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
