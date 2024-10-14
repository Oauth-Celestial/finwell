import 'package:flutter/material.dart';

//https://medium.com/flutter-community/everything-you-need-to-know-about-flutter-page-route-transition-9ef5c1b32823
class SlideRightRoute extends PageRouteBuilder {
  final Widget page;
  SlideRightRoute({required this.page})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
}

class StackSlide extends PageRouteBuilder {
  final Widget fromPage;
  final Widget to;

  StackSlide({required this.fromPage, required this.to})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) {
            return to;
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return Stack(
              children: [
                child,
                SlideTransition(
                  position:
                      Tween<Offset>(begin: Offset.zero, end: const Offset(1, 0))
                          .animate(animation),
                  child: fromPage,
                ),
              ],
            );
          },
        );
}

// class EnterExitRoute extends PageRouteBuilder {
//   final Widget enterPage;
//   final Widget exitPage;
//   EnterExitRoute({required this.exitPage, required this.enterPage})
//       : super(
//           pageBuilder: (
//             BuildContext context,
//             Animation<double> animation,
//             Animation<double> secondaryAnimation,
//           ) =>
//               enterPage,
//           transitionsBuilder: (
//             BuildContext context,
//             Animation<double> animation,
//             Animation<double> secondaryAnimation,
//             Widget child,
//           ) =>
//               Stack(
//             children: <Widget>[
//               enterPage,
//               SlideTransition(
//                   position: Tween<Offset>(
//                     begin: Offset.zero,
//                     end: const Offset(1, 0),
//                   ).animate(animation),
//                   child: exitPage),
//             ],
//           ),
//         );
// }
