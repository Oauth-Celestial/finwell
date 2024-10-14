import 'package:finwell/core/extensions/build_context.dart';
import 'package:finwell/core/route_manager/navigator_service.dart';
import 'package:finwell/core/route_manager/route_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //context.read<AuthBloc>().add(AuthLoggedInUser());
    Future.delayed(const Duration(milliseconds: 500), () {
      if (FirebaseAuth.instance.currentUser != null) {
        NavigationService().pushNamed(routeHomeScreen);
      } else {
        NavigationService().pushNamed(routeLoginScreen);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.currentTheme!.backgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            width: double.infinity,
          ),
          Text(
            "Finwell",
            style: TextStyle(
                color: context.currentTheme!.textColor,
                fontSize: 50.sp,
                fontWeight: FontWeight.w300,
                letterSpacing: 10),
          )
        ],
      ),
    );
  }
}



// https://www.youtube.com/watch?v=23eolFR-oho