import 'dart:math' as math;
import 'package:flutter/material.dart';

import '../../helpers/segments.dart';

class AnimatedProfilePic extends AnimatedWidget {
  const AnimatedProfilePic({
      super.key,
      required this.animation,
      required this.segments,
  }) : super(listenable: animation);

  final Animation<double> animation;
  final List<Segment> segments;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.pink,
      child: DecoratedBox(
        decoration: _ProfilePicOutlineDecoration(
          maxFraction: animation.value,
          segments: segments,
        ),
        child: Container(
          margin: const EdgeInsets.all(220),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: const DecorationImage(
                image: AssetImage('assets/trees.jpg'), fit: BoxFit.fill),
          ),
        ),
      ),
    );
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
