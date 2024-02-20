import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:roboli_site/helpers/constants.dart';

import '../../helpers/segments.dart';
import 'home_page/animated_profile_pic.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  late Animation<double> animationF;
  late Tween<double> moveForward;

  late Animation<double> animationB;
  late Tween<double> moveBackward;

  double pos = 0;

  static const twoPi = 2 * math.pi;
  static const lapse = 350;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, upperBound: twoPi);

    moveForward = Tween<double>(begin: pos, end: twoPi);
    animationF = moveForward.animate(controller);

    moveBackward = Tween<double>(begin: pos, end: twoPi);
    animationB = moveBackward.animate(controller);
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
        if (!mounted) return;

        final vector = center - details.localPosition;
        final angle = vector.direction;
        final end = angle + math.pi;
        var tweenEnd = (pos > end) ? (twoPi + end) : end;

        moveForward.begin = pos;
        moveForward.end = end;

        moveBackward.begin = pos;
        moveBackward.end = -tweenEnd;

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

    return LayoutBuilder(builder: (context, constraints) {
      final radius = math.min(
            constraints.maxWidth / 2,
            constraints.maxHeight / 2,
          ) /
          2;

      return Scaffold(
        body: Center(
          child: MouseRegion(
            onHover: _onMouseHover(size),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: AnimatedProfilePic(
                    animation: animationF,
                    segment: Segment(
                      color: Colors.green,
                      start: random.nextDouble() * twoPi,
                      size: twoPi * 0.875,
                      radius: radius + 20
                    ),
                    child: AnimatedProfilePic(
                      animation: animationB,
                      segment: Segment(
                        color: Colors.lightBlue,
                        start: random.nextDouble() * twoPi,
                        size: twoPi * 0.625,
                        radius: radius + 10,
                      ),
                      child: AnimatedProfilePic(
                        animation: animationF,
                        segment: Segment(
                          color: Colors.amberAccent,
                          start: random.nextDouble() * twoPi,
                          size: twoPi * 0.625,
                          radius: radius,
                        ),
                        child: (size.width > screenWBreakpoint) ? Container(
                          margin: EdgeInsets.all(radius - 60),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: const DecorationImage(
                              image:  AssetImage('assets/images/trees.jpg'), fit: BoxFit.fill),
                          ),
                        ) : SizedBox(
                          height: radius * 1.8,
                          width: radius * 1.8,
                          child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: const DecorationImage(
                              image:  AssetImage('assets/images/trees.jpg'), fit: BoxFit.fill),
                          ),
                        ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    'Hi there! Welcome to Roberto Oliveros\' home page.',
                    style: TextStyle(
                      fontSize: size.width > screenWBreakpoint ? 30 : 20
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 90,
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
