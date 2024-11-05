import 'package:finwell/core/app_user/model/app_user_model.dart';
import 'package:finwell/core/app_user/user_cubit/user_cubit_cubit.dart';
import 'package:finwell/core/extensions/build_context.dart';
import 'package:finwell/core/extensions/ext_date_time.dart';
import 'package:finwell/core/route_manager/navigator_service.dart';
import 'package:finwell/core/route_manager/route_manager.dart';
import 'package:finwell/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    AppUserModel? user = context.read<UserCubit>().state.userData;
    return Scaffold(
      backgroundColor: context.currentTheme!.backgroundColor,
      body: Column(
        children: [
          SizedBox(
            height: 20.h,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: double.infinity,
              child: Row(
                children: [
                  SizedBox(
                    width: 50.h,
                    height: 50.h,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.network(
                          fit: BoxFit.fill,
                          FirebaseAuth.instance.currentUser!.photoURL!),
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(user?.userName ?? ""),
                      SizedBox(
                        height: 3.h,
                      ),
                      Text(
                          "Joined on :- ${user!.joinedOn!.toCustomFormattedString()}")
                    ],
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                _showLogoutDialog(context);
              },
              child: Row(
                children: [
                  SizedBox(
                    width: 20.w,
                  ),
                  Icon(Icons.logout),
                  SizedBox(
                    width: 10.w,
                  ),
                  Text(
                    "Logout",
                    style: TextStyle(fontWeight: FontWeight.bold),
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

void _showLogoutDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Logout'),
        content: Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: Text('Cancel',
                style: TextStyle(color: context.currentTheme!.buttonColor)),
          ),
          TextButton(
            onPressed: () {
              // Perform logout action here
              context.read<UserCubit>().logoutUser();
              context.read<AuthBloc>().add(AuthLogoutUser());
              Navigator.of(context).pop(); // Close the dialog
              NavigationService().pushNamed(routeLoginScreen);
              print('User logged out');
            },
            child: Text(
              'Logout',
              style: TextStyle(color: context.currentTheme!.buttonColor),
            ),
          ),
        ],
      );
    },
  );
}
