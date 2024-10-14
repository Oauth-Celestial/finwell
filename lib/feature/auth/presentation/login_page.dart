import 'package:finwell/core/extensions/build_context.dart';
import 'package:finwell/core/theme/theme_model.dart';
import 'package:finwell/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:finwell/feature/onboarding/presentation/name_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:theme_manager_plus/theme_manager_plus.dart';
import 'package:zo_animated_border/zo_animated_border.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.currentTheme?.backgroundColor,
      body: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 100.h,
          ),
          SizedBox(
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Image.asset("assets/wallet.png")
                  .animate()
                  .slide(duration: const Duration(seconds: 1)),
            ),
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
          )
              .animate(delay: const Duration(seconds: 1))
              .fadeIn(duration: const Duration(seconds: 1)),
          const Spacer(),
          BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state.status == AuthStatus.success) {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => const NamePage()));
              }
            },
            builder: (context, state) {
              if (state.status == AuthStatus.loading) {
                return const CircularProgressIndicator();
              }

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: ZoAnimatedGradientBorder(
                  shouldAnimate: false,
                  width: double.infinity,
                  height: 55,
                  borderThickness: 2,
                  borderRadius: 100,
                  glowOpacity: 0,
                  gradientColor: const [Colors.blue, Colors.red],
                  child: InkWell(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onTap: () {
                      context.read<AuthBloc>().add(AuthLoginWithGoogle());
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                            width: 30,
                            height: 30,
                            child: Image.asset("assets/google.png")),
                        SizedBox(
                          width: 4.w,
                        ),
                        Container(
                          alignment: Alignment.center,
                          color: context.currentTheme?.backgroundColor,
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
          )
              .animate(delay: const Duration(seconds: 1))
              .fadeIn(duration: const Duration(seconds: 1))
              .slideY(duration: const Duration(milliseconds: 500)),
          SizedBox(
            height: 40.h,
          )
        ],
      ),
    );
  }
}
