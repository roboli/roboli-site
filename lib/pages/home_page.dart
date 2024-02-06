import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:easy_debounce/easy_debounce.dart';

import '../helpers/segments.dart';
import 'home_page/animated_profile_pic.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;
  late Tween<double> moveBetween;
  double pos = 0;

  static const twoPi = 2 * math.pi;
  static const lapse = 350;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, upperBound: twoPi);
    moveBetween = Tween<double>(begin: pos, end: twoPi);
    animation = moveBetween.animate(controller);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void Function(PointerEvent details) _onMouseHover(Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    void handleHover(PointerEvent details) {
      EasyDebounce.debounce('mouse-hover', const Duration(milliseconds: lapse),
          () {
        final vector = center - details.localPosition;
        final angle = vector.direction;
        final end = angle + math.pi;
        var tweenEnd = (pos > end) ? (twoPi + end) : end;

        moveBetween.begin = pos;
        moveBetween.end = tweenEnd;

        const spring = SpringDescription(mass: 1, stiffness: 60, damping: 10);
        final simulation =
            SpringSimulation(spring, 0, 1, -(vector.distance / lapse));

        controller.animateWith(simulation);

        pos = end;
      });
    }

    return handleHover;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final random = math.Random();

    return Scaffold(
      body: Center(
        child: MouseRegion(
          onHover: _onMouseHover(size),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(height: 20,),
              Expanded(
                child: AnimatedProfilePic(
                  animation: animation,
                  segments: [
                    Segment(
                      color: Colors.green,
                      start: random.nextDouble() * twoPi,
                      size: twoPi * 0.875,
                    ),
                    Segment(
                        color: Colors.blue,
                        start: random.nextDouble() * twoPi,
                        size: twoPi * 0.625),
                    Segment(
                      color: Colors.amberAccent,
                      start: random.nextDouble() * twoPi,
                      size: twoPi * 0.375,
                    )
                  ],
                ),
              ),
              const Text(
                'Hi there! Welcome to Roberto Oliveros\' home page.',
                style: TextStyle(fontSize: 30),
              ),
              const SizedBox(height: 90,),
            ],
          ),
        ),
      ),
    );
  }
}
