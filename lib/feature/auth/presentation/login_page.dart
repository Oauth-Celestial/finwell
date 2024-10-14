import 'package:finwell/core/extensions/build_context.dart';
import 'package:finwell/core/route_manager/navigator_service.dart';
import 'package:finwell/core/route_manager/route_manager.dart';
import 'package:finwell/core/theme/theme_model.dart';
import 'package:finwell/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:theme_manager_plus/theme_manager_plus.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.currentTheme?.backgroundColor,
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
            padding: EdgeInsets.symmetric(horizontal: 2.w),
            child: Column(
              children: [
                SizedBox(
                  height: 5.h,
                ),
                Text(
                  "Plan Today, Prosper Tomorrow.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: context.themeOf<FinThemeModel>()!.textColor,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Text(
                    "Every great journey begins with a single step. Let’s take that step together!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: context.currentTheme?.textColor.withOpacity(0.8),
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    )),
              ],
            ),
          ),
          const Spacer(),
          BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state.status == AuthStatus.success) {
                NavigationService().pushNamed(routeNameScreen);
              }
            },
            builder: (context, state) {
              if (state.status == AuthStatus.loading) {
                return CircularProgressIndicator(
                  color: context.currentTheme?.buttonColor,
                );
              }

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: InkWell(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: () {
                    context.read<AuthBloc>().add(AuthLoginWithGoogle());
                  },
                  child: Container(
                    height: 45.h,
                    decoration: BoxDecoration(
                        color: context.currentTheme?.buttonColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          child: const Text(
                            "Login With Google",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          SizedBox(
            height: 40.h,
          )
        ],
      ),
    );
  }
}
