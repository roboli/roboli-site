import 'package:flutter/material.dart';

class SiteTab extends StatefulWidget {
  const SiteTab({
      super.key,
      required this.title,
      required this.icon,
      required this.isExpanded,
  });

  final Text title;
  final Icon icon;
  final bool isExpanded;

  @override
  SiteTabState createState() => SiteTabState();
}

class SiteTabState extends State<SiteTab>
    with SingleTickerProviderStateMixin {
  late Animation<double> _titleSizeAnimation;
  late Animation<double> _titleFadeAnimation;
  late Animation<double> _iconFadeAnimation;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _titleSizeAnimation = _controller.view;
    _titleFadeAnimation = _controller.drive(CurveTween(curve: Curves.easeOut));
    _iconFadeAnimation = _controller.drive(Tween<double>(begin: 0.6, end: 1));
    if (widget.isExpanded) {
      _controller.value = 1;
    }
  }

  @override
  void didUpdateWidget(SiteTab oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isExpanded) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 18),
        FadeTransition(
          opacity: _iconFadeAnimation,
          child: widget.icon,
        ),
        const SizedBox(height: 12),
        FadeTransition(
          opacity: _titleFadeAnimation,
          child: SizeTransition(
            axis: Axis.vertical,
            axisAlignment: -1,
            sizeFactor: _titleSizeAnimation,
            child: Center(child: ExcludeSemantics(child: widget.title)),
          ),
        ),
        const SizedBox(height: 18),
      ],
    );
  }
}
