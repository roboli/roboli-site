import 'package:flutter/material.dart';

class MainPanel extends StatefulWidget {
  const MainPanel({super.key, required this.child, required this.index});

  final Widget child;
  final int index;

  @override
  State<StatefulWidget> createState() => _MainPanelState();
}

class _MainPanelState extends State<MainPanel>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 900),
      vsync: this,
    );
    _fadeAnimation = _controller.drive(CurveTween(curve: Curves.easeOut));
    _controller.forward();
  }

  @override
  void didUpdateWidget(MainPanel oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.index != widget.index) {
      _controller.reset();
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: widget.child,
    );
  }
}
