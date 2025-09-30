import 'package:flutter/material.dart';

class AnimatedProductOverlay extends StatefulWidget {
  final Offset start;
  final Offset end;
  final Widget child;

  const AnimatedProductOverlay({
    super.key,
    required this.start,
    required this.end,
    required this.child,
  });

  @override
  State<AnimatedProductOverlay> createState() => _AnimatedProductOverlayState();
}

class _AnimatedProductOverlayState extends State<AnimatedProductOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(milliseconds: 600), vsync: this);
    _animation = Tween<Offset>(
      begin: widget.start,
      end: widget.end,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (_, __) =>
          Positioned(left: _animation.value.dx, top: _animation.value.dy, child: widget.child),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
