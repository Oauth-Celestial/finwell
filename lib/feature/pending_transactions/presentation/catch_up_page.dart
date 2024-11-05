import 'package:finwell/core/extensions/build_context.dart';
import 'package:finwell/core/route_manager/navigator_service.dart';
import 'package:finwell/core/route_manager/route_manager.dart';
import 'package:finwell/core/shared_prefs/shared_pref_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:permission_handler/permission_handler.dart';

class CatchUpStartPage extends StatefulWidget {
  const CatchUpStartPage({super.key});

  @override
  State<CatchUpStartPage> createState() => _CatchUpStartPageState();
}

class _CatchUpStartPageState extends State<CatchUpStartPage> {
  Future<bool> _requestSmsPermission() async {
    PermissionStatus status = await Permission.sms.status;
    if (status.isDenied) {
      // Request the permission
      status = await Permission.sms.request();
    }

    if (status.isGranted) {
      // Permission granted
      return true;
    } else if (status.isDenied) {
      // Permission denied
      return false;
    } else if (status.isPermanentlyDenied) {
      return false;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 20.h,
          ),
          SvgPicture.asset(
            "assets/svgs/login.svg",
            width: 100.w,
            height: 300.h,
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
                  "Catch-Up Transactions ",
                  style: TextStyle(
                      color: context.currentTheme!.textColor,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Text(
                  "Instantly view and manage any missed or pending transactions to ensure your records are always up-to-date. Whether you overlooked a transaction or need to log pending ones",
                  style: TextStyle(
                    color: context.currentTheme?.textColor.withOpacity(0.8),
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 45.h,
              decoration: BoxDecoration(
                  color: context.currentTheme?.buttonColor,
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () async {
                      bool hasAccess = await _requestSmsPermission();
                      if (hasAccess) {
                        SharedPrefManager().saveCatchScreenShow();
                        NavigationService().pushNamed(routePendingTransaction);
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      child: const Text(
                        "Enable Catch Up",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
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
