import 'package:finwell/core/app_user/user_cubit/user_cubit_cubit.dart';
import 'package:finwell/core/extensions/build_context.dart';
import 'package:finwell/core/route_manager/navigator_service.dart';
import 'package:finwell/core/route_manager/route_manager.dart';
import 'package:finwell/core/widgets/circle_reval_animation_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserCreationSuccess extends StatefulWidget {
  const UserCreationSuccess({super.key});

  @override
  State<UserCreationSuccess> createState() => _UserCreationSuccessState();
}

class _UserCreationSuccessState extends State<UserCreationSuccess>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  @override
  Widget build(BuildContext context) {
    String userName =
        context.read<UserCubitCubit>().state.userData?.userName ?? "";
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: CircularRevealAnimation(
          revelWidget: Column(
            children: [
              SizedBox(
                height: 50.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                child: Image.asset("assets/welcome.png"),
              ),
              Text(
                "Welcome aboard",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: context.currentTheme!.textColor,
                    fontSize: 25.sp,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 20.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Text(
                  textAlign: TextAlign.center,
                  "We're thrilled to have you with us. Let’s take the first step towards achieving your financial goals and building a brighter future. We're here to guide you every step of the way",
                  style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      color: context.currentTheme!.textColor.withOpacity(0.6)),
                ),
              ),
              const Spacer(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: InkWell(
                  onTap: () {
                    NavigationService().pushNamed(routeDashboardScreen);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    height: 40.h,
                    decoration: BoxDecoration(
                      color: context.currentTheme!.buttonColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      "Let's Get Started",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15.h,
              )
            ],
          ),
        ),
      ),
    );
  }
}
