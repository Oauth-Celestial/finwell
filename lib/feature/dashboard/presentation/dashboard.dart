// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:finwell/core/app_updater/app_update_service.dart';
import 'package:finwell/core/app_user/user_cubit/user_cubit_cubit.dart';
import 'package:finwell/core/extensions/build_context.dart';
import 'package:finwell/core/extensions/ext_date_time.dart';
import 'package:finwell/core/route_manager/navigator_service.dart';
import 'package:finwell/feature/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:finwell/feature/dashboard/presentation/pages/home_page.dart';
import 'package:finwell/feature/transaction/presentation/bloc/transaction_bloc.dart';
import 'package:finwell/feature/transaction/presentation/transaction_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  List<Widget> _buildScreens() {
    return [
      const HomePage(),
      const TransactionPage(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.calendar),
        title: ("Home"),
        activeColorPrimary: context.currentTheme!.buttonColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.bitcoin),
        title: ("Transactions"),
        activeColorPrimary: context.currentTheme!.buttonColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }

  @override
  void initState() {
    // TODO: implement initState
    NavigationService().navigationContext!.read<UserCubit>().getCurrentUser();

    NavigationService().navigationContext!.read<TransactionBloc>().add(
        FetchTransactionEvent(
            transactionDate: DateTime.now().toCustomFormattedString()));
    AppUpdateService().checkForUpdate();
    context.read<DashboardBloc>().add(LoadDashBoardEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: context.currentTheme!.backgroundColor,
        body: BlocBuilder<UserCubit, UserCubitState>(
          builder: (context, state) {
            return state.status != UserStatus.loggedin
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : PersistentTabView(
                    context,
                    controller: _controller,
                    screens: _buildScreens(),
                    items: _navBarsItems(),
                    handleAndroidBackButtonPress: true, // Default is true.
                    resizeToAvoidBottomInset:
                        true, // This needs to be true if you want to move up the screen on a non-scrollable screen when keyboard appears. Default is true.
                    stateManagement: true, // Default is true.
                    hideNavigationBarWhenKeyboardAppears: true,

                    padding: const EdgeInsets.only(top: 8),
                    backgroundColor: context.currentTheme!.backgroundColor,
                    isVisible: true,

                    confineToSafeArea: true,
                    navBarHeight: kBottomNavigationBarHeight + 5,
                    navBarStyle: NavBarStyle
                        .style3, // Choose the nav bar style with this property
                  );
          },
        ));
  }
}
