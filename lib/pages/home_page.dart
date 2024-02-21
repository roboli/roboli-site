import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:roboli_site/helpers/constants.dart';
import 'package:roboli_site/pages/home_page/ring_manager.dart';

import '../../helpers/segments.dart';
import 'home_page/animated_ring.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static const twoPi = 2 * math.pi;

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

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, upperBound: HomePage.twoPi);

    moveForward = Tween<double>(begin: 0, end: HomePage.twoPi);
    animationF = moveForward.animate(controller);

    moveBackward = Tween<double>(begin: HomePage.twoPi, end: 0);
    animationB = moveBackward.animate(controller);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
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
          child: ConstrainedBox(
            constraints: const BoxConstraints(minWidth: double.infinity),
            child: RingManager(
              size: size,
              controller: controller,
              forward: moveForward,
              backward: moveBackward,
              startPos: HomePage.twoPi,
              mounted: mounted,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: AnimatedRing(
                      animation: animationF,
                      segment: Segment(
                        color: Colors.green,
                        start: random.nextDouble() * HomePage.twoPi,
                        size: HomePage.twoPi * 0.875,
                        radius: radius + 20
                      ),
                      child: AnimatedRing(
                        animation: animationB,
                        segment: Segment(
                          color: Colors.lightBlue,
                          start: random.nextDouble() * HomePage.twoPi,
                          size: HomePage.twoPi * 0.625,
                          radius: radius + 10,
                        ),
                        child: AnimatedRing(
                          animation: animationF,
                          segment: Segment(
                            color: Colors.amberAccent,
                            start: random.nextDouble() * HomePage.twoPi,
                            size: HomePage.twoPi * 0.625,
                            radius: radius,
                          ),
                          child: CircleAvatar(
                            radius: radius - 20,
                            backgroundImage: const AssetImage('assets/images/roberto.jpg'),
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
        ),
      );
    });
  }
}
