import 'package:finwell/core/app_user/model/app_user_model.dart';
import 'package:finwell/core/app_user/user_cubit/user_cubit_cubit.dart';
import 'package:finwell/core/extensions/build_context.dart';
import 'package:finwell/core/route_manager/navigator_service.dart';
import 'package:finwell/core/route_manager/route_manager.dart';
import 'package:finwell/core/shared_prefs/shared_pref_manager.dart';
import 'package:finwell/feature/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:finwell/feature/transaction/presentation/transaction_page.dart';
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
    // platform.invokeMethod(
    //   "getForegroundPackage",
    // );

    platform.invokeMethod("getPaymentApps").then((value) {
      print(value);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppUserModel? currentuser = context.read<UserCubit>().state.userData;
    print(currentuser?.userName);
    return Scaffold(
      backgroundColor: context.currentTheme!.backgroundColor.withOpacity(0.8),
      body: SafeArea(
        child: BlocConsumer<DashboardBloc, DashboardState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            if (state.status == DashboardStatus.loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20.h,
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
                  height: 20.h,
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
                        "₹ ${state.data?.expenseAmount ?? "0"}",
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
                        "₹ ${state.data?.incomeAmount ?? "0"}",
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
                  child: Text(
                    "Tools",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 15.sp),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.only(start: 15.w, top: 10.h),
                  child: Row(
                    children: [
                      Expanded(
                        child: LayoutBuilder(builder: (context, constraints) {
                          return ZoAnimatedGradientBorder(
                            borderRadius: 15,
                            shouldAnimate: false,
                            blurRadius: 5,
                            spreadRadius: 0,
                            width: constraints.maxWidth,
                            height: 100,
                            gradientColor: [Colors.red, Colors.blue],
                            child: Container(
                              margin: EdgeInsets.all(8),
                              child: InkWell(
                                onTap: () {
                                  if (SharedPrefManager().getCatchupStatus()) {
                                    NavigationService()
                                        .pushNamed(routePendingTransaction);
                                  } else {
                                    NavigationService()
                                        .pushNamed(routeCatchUpPage);
                                  }
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                    Text(
                                      "Catch-Up",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                    Text("Catch up With missed transaction ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w300,
                                            fontSize: 11.sp))
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Expanded(
                        child: LayoutBuilder(builder: (context, constraints) {
                          return ZoAnimatedGradientBorder(
                            borderRadius: 15,
                            shouldAnimate: false,
                            blurRadius: 5,
                            spreadRadius: 0,
                            width: constraints.maxWidth,
                            height: 100,
                            gradientColor: [Colors.red, Colors.blue],
                            child: InkWell(
                              onTap: () async {
                                NavigationService().pushNamed(routeNoSpendMode);
                                // bool isServiceRunning = await platform.invokeMethod(
                                //   "isServiceRunning",
                                // );
                                // print(isServiceRunning);

                                // platform.invokeMethod(
                                //   "getForegroundPackage",
                                // );
                              },
                              child: Container(
                                margin: EdgeInsets.all(8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                    Text(
                                      "No Spend Mode",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                    Text(
                                        "Helps you achieve a perfect no spend day",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w300,
                                            fontSize: 11.sp))
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 5.r,
                            blurRadius: 7.r,
                            offset: const Offset(0, 3),
                          ),
                        ],
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: double.infinity,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Recent Transaction",
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.8),
                                  fontWeight: FontWeight.w300,
                                  fontSize: 15.sp),
                            ),
                          ),
                          Expanded(
                              child: Center(
                            child: (state.data?.recenntTransactions ?? [])
                                    .isEmpty
                                ? Container(
                                    child: Text("No Transactions "),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ListView.builder(
                                        itemCount:
                                            (state.data?.recenntTransactions ??
                                                    [])
                                                .length,
                                        itemBuilder: (context, index) {
                                          return TransactionCard(
                                              transaction: state.data
                                                  ?.recenntTransactions[index]);
                                        }),
                                  ),
                          ))
                        ],
                      ),
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
