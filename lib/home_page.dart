import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:easy_debounce/easy_debounce.dart';

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
        child: Container(
          width: size.width,
          height: size.height,
          color: Colors.transparent,
          child: ConstrainedBox(
            constraints: BoxConstraints.tight(const Size(500, 500)),
            child: MouseRegion(
              onHover: _onMouseHover(size),
              child: _AnimatedProfilePic(
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
                      size: twoPi * 0.625
                    ),
                  Segment(
                    color: Colors.amberAccent,
                    start: random.nextDouble() * twoPi,
                    size: twoPi * 0.375,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _AnimatedProfilePic extends AnimatedWidget {
  const _AnimatedProfilePic({
    required this.animation,
    required this.segments,
  }) : super(listenable: animation);

  final Animation<double> animation;
  final List<Segment> segments;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final ratio = size.width / size.height;

    return LayoutBuilder(builder: (context, constraints) {
      return DecoratedBox(
        decoration: _ProfilePicOutlineDecoration(
          maxFraction: animation.value,
          segments: segments,
        ),
        child: Container(
          height: constraints.maxHeight,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: size.width * 0.26,
                height: size.height * 0.52,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: const DecorationImage(
                      image: AssetImage('assets/roberto.png'),
                      fit: BoxFit.fill),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

class _ProfilePicOutlineDecoration extends Decoration {
  const _ProfilePicOutlineDecoration({
    required this.maxFraction,
    required this.segments,
  });

  final double maxFraction;
  final List<Segment> segments;

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _ProfilePicOutlineBoxPainter(
      maxFraction: maxFraction,
      segments: segments,
    );
  }
}

class _ProfilePicOutlineBoxPainter extends BoxPainter {
  _ProfilePicOutlineBoxPainter({
    required this.maxFraction,
    required this.segments,
  });

  final double maxFraction;
  final List<Segment> segments;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    // Create two padded reacts to draw arcs in: one for colored arcs and one for
    // inner bg arc.
    final outerRadius = math.min(
          configuration.size!.width / 2,
          configuration.size!.height / 2,
        ) /
        2;

    final innerRect = Rect.fromCircle(
      center: configuration.size!.center(offset),
      radius: outerRadius,
    );

    double i = 0;

    for (final segment in segments) {
      final segmentRect = Rect.fromCircle(
        center: configuration.size!.center(offset),
        radius: (outerRadius + i),
      );

      final paint = Paint()
        ..color = segment.color
        ..style = PaintingStyle.stroke
        ..strokeWidth = 8.0;

      canvas.drawArc(
          segmentRect, maxFraction + segment.start, segment.size, false, paint);

      i += 10;
    }

    // Paint a smaller inner circle to cover the painted arcs, so they are
    // display as segments.
    final bgPaint = Paint()..color = Colors.transparent;
    canvas.drawArc(innerRect, 0, 2 * math.pi, true, bgPaint);
  }
}

class Segment {
  const Segment({
    required this.color,
    required this.start,
    required this.size,
  });

  final Color color;
  final double start;
  final double size;
}
