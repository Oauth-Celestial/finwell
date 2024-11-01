import 'package:finwell/core/extensions/build_context.dart';
import 'package:finwell/core/extensions/ext_date_time.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PendingTransactionPage extends StatelessWidget {
  const PendingTransactionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.currentTheme!.backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Pending Transactions"),
      ),
      body: Column(
        children: [
          Container(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Transaction Amount : - 200"),
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.calendar_month,
                              size: 18,
                              color: context.currentTheme!.buttonColor,
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Text(
                                DateTime.now().toCustomFormattedString() ?? ""),
                            Spacer(),
                          ],
                        )
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        width: 35.w,
                        height: 35.w,
                        child: Icon(
                          Icons.check,
                          color: Colors.white,
                        ),
                        decoration: BoxDecoration(
                            color: context.currentTheme!.buttonColor,
                            shape: BoxShape.circle),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Container(
                        width: 35.w,
                        height: 35.w,
                        child: Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                        decoration: BoxDecoration(
                            color: Colors.red, shape: BoxShape.circle),
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
