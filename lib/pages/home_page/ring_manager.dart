import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:roboli_site/helpers/device.dart';

class RingManager extends StatefulWidget {
  final Widget child;
  final AnimationController controller;
  final Tween<double> forward;
  final Tween<double> backward;
  final double startPos;
  final bool mounted;
  late final Offset center;

  static const lapse = 350;

  RingManager(
      {super.key,
      required this.child,
      required this.controller,
      required this.forward,
      required this.backward,
      required this.startPos,
      required this.mounted,
      required size})
      : center = Offset(size.width / 2, size.height / 2);

  @override
  State<RingManager> createState() => _RingManagerState();
}

class _RingManagerState extends State<RingManager> {
  double pos = 0;
  bool isMoving = false;

  @override
  void initState() {
    super.initState();

    if (isWebMobile) {
      _toggleAnimation();
    }
  }

  void _toggleAnimation() {
    if (isMoving) {
      widget.controller.stop();
      setState(() {
        isMoving = false;
      });
    } else {
      widget.controller.repeat(period: const Duration(seconds: 50));
      setState(() {
        isMoving = true;
      });
    }
  }

  void _handleTap() {
    _toggleAnimation();
  }

  void _handleMouseHover(PointerEvent details) {
    EasyDebounce.debounce(
        'mouse-hover', const Duration(milliseconds: RingManager.lapse), () {
      if (!widget.mounted) return;

      final vector = widget.center - details.localPosition;
      final angle = vector.direction;
      final end = angle + math.pi;
      var tweenEnd = (pos > end) ? (widget.startPos + end) : end;

      widget.forward.begin = pos;
      widget.forward.end = end;

      widget.backward.begin = pos;
      widget.backward.end = -tweenEnd;

      const spring = SpringDescription(mass: 1, stiffness: 60, damping: 10);
      final simulation = SpringSimulation(
          spring, 0, 1, -(vector.distance / RingManager.lapse));

      widget.controller.animateWith(simulation);

      pos = end;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isWebMobile) {
      return GestureDetector(
        onTap: _handleTap,
        child: Container(
          color: isMoving ? Colors.blueGrey : Colors.transparent,
          child: widget.child
        ),
      );
    } else {
      return MouseRegion(
        onHover: _handleMouseHover,
        child: widget.child,
      );
    }
  }
}
