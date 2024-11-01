// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:finwell/core/app_user/user_cubit/user_cubit_cubit.dart';
import 'package:finwell/core/extensions/build_context.dart';
import 'package:finwell/core/extensions/ext_date_time.dart';
import 'package:finwell/core/route_manager/navigator_service.dart';
import 'package:finwell/core/route_manager/route_manager.dart';
import 'package:finwell/feature/dashboard/presentation/pages/profile_page.dart';
import 'package:finwell/feature/dashboard/presentation/pages/stats_page.dart';
import 'package:finwell/feature/transaction/presentation/bloc/transaction_bloc.dart';
import 'package:finwell/feature/transaction/presentation/home_page.dart';
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
    return [const HomePage(), const StatsPage(), const ProfilePage()];
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
        icon: const Icon(CupertinoIcons.graph_square),
        title: ("Stats"),
        activeColorPrimary: context.currentTheme!.buttonColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.profile_circled),
        title: ("Profile"),
        activeColorPrimary: context.currentTheme!.buttonColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }

  @override
  void initState() {
    // TODO: implement initState
    NavigationService()
        .navigationContext!
        .read<UserCubitCubit>()
        .getCurrentUser();

    NavigationService().navigationContext!.read<TransactionBloc>().add(
        FetchTransactionEvent(
            transactionDate: DateTime.now().toCustomFormattedString()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: context.currentTheme!.backgroundColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: context.currentTheme!.backgroundColor,
          title: Text(
            "Finwell",
            style: TextStyle(
                color: context.currentTheme!.textColor,
                fontWeight: FontWeight.bold),
          ),
          actions: [
            BellIcon(
              onPressed: () {
                Navigator.pushNamed(context, routePendingTransaction);
              },
            )
          ],
        ),
        body: BlocBuilder<UserCubitCubit, UserCubitState>(
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

class BellIcon extends StatefulWidget {
  Function() onPressed;
  BellIcon({
    Key? key,
    required this.onPressed,
  }) : super(key: key);
  @override
  _BellIconState createState() => _BellIconState();
}

class _BellIconState extends State<BellIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 1.0, end: 1.2).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _animation,
      child: IconButton(
        icon: Icon(
          Icons.notifications,
          size: 25,
          color: context.currentTheme!.buttonColor,
        ),
        onPressed: () {
          widget.onPressed();
        },
      ),
    );
  }
}
