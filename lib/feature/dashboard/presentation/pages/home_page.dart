import 'package:finwell/core/app_user/model/app_user_model.dart';
import 'package:finwell/core/app_user/user_cubit/user_cubit_cubit.dart';
import 'package:finwell/core/extensions/build_context.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zo_animated_border/zo_animated_border.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  MethodChannel platform = MethodChannel(
    'timeTracker',
  );
  @override
  void initState() {
    // TODO: implement initState
    platform.invokeMethod(
      "getForegroundPackage",
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppUserModel? currentuser = context.read<UserCubit>().state.userData;
    print(currentuser?.userName);
    return Scaffold(
      backgroundColor: context.currentTheme!.backgroundColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10.h,
            ),
            Row(
              children: [
                SizedBox(
                  width: 10.w,
                ),
                ZoAnimatedGradientBorder(
                  width: 40.h,
                  height: 40.h,
                  gradientColor: [Colors.blue, Colors.red],
                  shouldAnimate: false,
                  spreadRadius: 0,
                  borderThickness: 2,
                  blurRadius: 0,
                  child: SizedBox(
                    width: 40.h,
                    height: 40.h,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.network(
                          fit: BoxFit.fill,
                          FirebaseAuth.instance.currentUser!.photoURL!),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hey There",
                      style: TextStyle(
                          fontWeight: FontWeight.w300,
                          color: Colors.black.withOpacity(0.6),
                          fontSize: 12.sp),
                    ),
                    Text(
                      currentuser?.userName ?? "John doe",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 13.sp),
                    )
                  ],
                ),
                Spacer(),
                Icon(
                  Icons.notifications,
                  color: context.currentTheme!.buttonColor,
                ),
                SizedBox(
                  width: 10.w,
                )
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            Padding(
              padding: EdgeInsetsDirectional.only(start: 15.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Expense These Month",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Text(
                    "₹ 0",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 21.sp,
                      fontWeight: FontWeight.w300,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            Padding(
              padding: EdgeInsetsDirectional.only(start: 15.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Income These Month",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Text(
                    "₹ 0",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 21.sp,
                      fontWeight: FontWeight.w300,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            Padding(
              padding: EdgeInsetsDirectional.only(start: 15.w),
              child: Text("Tools"),
            )
          ],
        ),
      ),
    );
  }
}
