import 'package:finwell/core/route_manager/navigator_service.dart';
import 'package:finwell/core/route_manager/route_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class PreLoginOnboardingScreen extends StatefulWidget {
  const PreLoginOnboardingScreen({super.key});

  @override
  State<PreLoginOnboardingScreen> createState() =>
      _PreLoginOnboardingScreenState();
}

class _PreLoginOnboardingScreenState extends State<PreLoginOnboardingScreen> {
  final PageController _pageController = PageController();
  int currentPage = 0;

  List<Map<String, String>> onboardingData = [
    {
      "image": "assets/onboarding/onboarding1.svg",
      "title": "Struggling with Spending",
      "description":
          "Are your finances all over the place? We help you make sense of where your money goes, giving you clear insights into your spending habits."
    },
    {
      "image": "assets/onboarding/onboarding2.svg",
      "title": "Confused About Budgeting?",
      "description":
          "Not sure where to start? Our AI-powered suggestions help you create a smarter budget, tailored to your lifestyle and financial goals."
    },
    {
      "image": "assets/onboarding/onboarding3.svg",
      "title": "Understanding Your Expenses",
      "description":
          "Categorize and visualize your expenses with ease. From bills to savings, see the big picture of your finances in one glance."
    },
    {
      "image": "assets/onboarding/onboarding4.svg",
      "title": "Powered by AI",
      "description":
          "Let AI do the heavy lifting! Our AI analyzes your spending patterns and provides insights to help you make better financial decisions."
    }
  ];
  void _handleButtonPress() {
    if (currentPage < onboardingData.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      NavigationService().pushNamed(routeLoginScreen);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 196, 230, 197),
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: PageView.builder(
                controller: _pageController,
                onPageChanged: (value) {
                  setState(() {
                    currentPage = value;
                  });
                },
                itemCount: onboardingData.length,
                itemBuilder: (context, index) => SvgPicture.asset(
                    onboardingData[index]['image'].toString())),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              onboardingData.length,
              (index) => AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: EdgeInsets.only(right: 5.w),
                height: 10.h,
                width: currentPage == index ? 30 : 10,
                decoration: BoxDecoration(
                  color: currentPage == index ? Colors.green : Colors.white,
                  borderRadius: BorderRadius.circular(5.r),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              width: ScreenUtil().screenWidth,
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 20.h),
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 5.r,
                        blurRadius: 7.r,
                        offset: const Offset(0, 3)),
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.r)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    onboardingData[currentPage]["title"]!,
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Gap(10.h),
                  Text(
                    onboardingData[currentPage]["description"]!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.black54,
                    ),
                  ),
                  Gap(20.h),
                  ElevatedButton(
                    onPressed: _handleButtonPress,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: EdgeInsets.symmetric(
                          horizontal: 50.w, vertical: 15.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                    ),
                    child: Text(
                      currentPage != 3 ? 'Next' : "Continue",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
