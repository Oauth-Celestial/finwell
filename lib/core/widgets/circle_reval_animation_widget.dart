import 'package:flutter/cupertino.dart';

class CircularRevealAnimation extends StatefulWidget {
  Widget revelWidget;
  Duration? animationDuration;
  CircularRevealAnimation(
      {super.key, required this.revelWidget, this.animationDuration});

  @override
  State<CircularRevealAnimation> createState() =>
      _CircularRevealAnimationState();
}

class _CircularRevealAnimationState extends State<CircularRevealAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.animationDuration ?? const Duration(seconds: 2),
    );

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _controller.forward(); // Start the animation
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return ClipPath(
          clipper: CircleRevealClipper(_animation.value),
          child: widget.revelWidget,
        );
      },
    );
  }
}

class CircleRevealClipper extends CustomClipper<Path> {
  final double revealPercent;

  CircleRevealClipper(this.revealPercent);

  @override
  Path getClip(Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width * 2 * revealPercent;
    return Path()..addOval(Rect.fromCircle(center: center, radius: radius));
  }

  @override
  bool shouldReclip(CircleRevealClipper oldClipper) {
    return oldClipper.revealPercent != revealPercent;
  }
}
