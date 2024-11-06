import 'dart:async';

import 'package:finwell/core/extensions/build_context.dart';
import 'package:finwell/core/route_manager/navigator_service.dart';
import 'package:finwell/core/route_manager/route_manager.dart';
import 'package:finwell/feature/auth/presentation/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NoSpendMode extends StatefulWidget {
  const NoSpendMode({super.key});

  @override
  State<NoSpendMode> createState() => _NoSpendModeState();
}

class _NoSpendModeState extends State<NoSpendMode> {
  bool hasPermission = false;
  bool isServiceRunning = false;
  MethodChannel platform = MethodChannel(
    'timeTracker',
  );
  Timer? timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    UsageStatsPermission.hasUsageStatsPermission().then((value) {
      if (value) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          setState(() {
            hasPermission = true;
          });
        });
      }
    });

    platform.invokeMethod("isServiceRunning").then((value) {
      if (value) {
        isServiceRunning = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.currentTheme!.backgroundColor,
      body: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 20.h,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Image.asset("assets/no_spend.jpg"),
          ),
          SizedBox(
            height: 40.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 5.h,
                ),
                Text(
                  "No Spend Mode",
                  style: TextStyle(
                      color: context.currentTheme!.textColor,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Text(
                  "No-Spend Mode, a challenge designed to push your spending boundaries. Once activated, this feature locks down apps with payment functionality",
                  style: TextStyle(
                    color: context.currentTheme?.textColor.withOpacity(0.8),
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 15.h,
          ),
          FutureBuilder<bool>(
              initialData: false,
              future: UsageStatsPermission.hasUsageStatsPermission(),
              builder: (context, snapshot) {
                if (snapshot.data ?? false) {
                  return Container();
                }
                print("No Permission");
                return Padding(
                  padding: EdgeInsets.only(left: 10.w),
                  child: Row(
                    children: [
                      Text(
                        "Require usage permission ",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 15.sp),
                      ),
                      Spacer(),
                      InkWell(
                        onTap: () {
                          UsageStatsPermission.requestUsageStatsPermission();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: context.currentTheme!.buttonColor,
                              borderRadius: BorderRadius.circular(5)),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.w, vertical: 8),
                            child: Text(
                              "Grant",
                              style: TextStyle(
                                  color: context.currentTheme!.backgroundColor),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20.w,
                      )
                    ],
                  ),
                );
              }),
          SizedBox(
            height: 10.h,
          ),
          Padding(
            padding: EdgeInsets.only(left: 10.w),
            child: Row(
              children: [
                Text(
                  "Require overlay permission ",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 15.sp),
                ),
                Spacer(),
                InkWell(
                  onTap: () {
                    platform.invokeMethod("askDrawPermission");
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: context.currentTheme!.buttonColor,
                        borderRadius: BorderRadius.circular(5)),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.w, vertical: 8),
                      child: Text(
                        "Grant",
                        style: TextStyle(
                            color: context.currentTheme!.backgroundColor),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 20.w,
                )
              ],
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 45.h,
              decoration: BoxDecoration(
                  color: isServiceRunning
                      ? Colors.red
                      : context.currentTheme?.buttonColor,
                  borderRadius: BorderRadius.circular(10)),
              child: InkWell(
                onTap: () async {
                  bool hasPermission =
                      await UsageStatsPermission.hasUsageStatsPermission();
                  if (hasPermission) {
                    if (isServiceRunning) {
                      platform.invokeMethod("stopForegroundService");
                      final snackBar = SnackBar(
                        content: Text('No Spend Mode Stopped'),
                        action: SnackBarAction(
                          label: 'ok',
                          onPressed: () {},
                        ),
                      );

                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      NavigationService().popUntil(routeDashboardScreen);
                    } else {
                      platform.invokeMethod("startForeGround");
                      final snackBar = SnackBar(
                        content: Text('No Spend Mode Enabled'),
                        action: SnackBarAction(
                          label: 'ok',
                          onPressed: () {
                            // Code to execute on action press
                          },
                        ),
                      );

                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      NavigationService().popUntil(routeDashboardScreen);
                    }
                  } else {
                    final snackBar = SnackBar(
                      content: Text('Please Grant Usage Permission'),
                      action: SnackBarAction(
                        label: 'ok',
                        onPressed: () {
                          // Code to execute on action press
                        },
                      ),
                    );

                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    isServiceRunning ? "Stop No Spend" : "Enable No Spend",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10.h,
          )
        ],
      ),
    );
  }
}
