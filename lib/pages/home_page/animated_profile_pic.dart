import 'package:flutter/material.dart';

import '../../helpers/segments.dart';

class AnimatedProfilePic extends AnimatedWidget {
  const AnimatedProfilePic(
      {super.key, required this.animation, required this.segment, this.child})
      : super(listenable: animation);

  final Animation<double> animation;
  final Segment segment;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: _ProfilePicOutlineDecoration(
        maxFraction: animation.value,
        segment: segment,
      ),
      child: child,
    );
  }
}

class _ProfilePicOutlineDecoration extends Decoration {
  const _ProfilePicOutlineDecoration({
    required this.maxFraction,
    required this.segment,
  });

  final double maxFraction;
  final Segment segment;

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _ProfilePicOutlineBoxPainter(
      maxFraction: maxFraction,
      segment: segment,
    );
  }
}

class _ProfilePicOutlineBoxPainter extends BoxPainter {
  _ProfilePicOutlineBoxPainter({
    required this.maxFraction,
    required this.segment,
  });

  final double maxFraction;
  final Segment segment;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final segmentRect = Rect.fromCircle(
        center: configuration.size!.center(offset), radius: segment.radius);

    final paint = Paint()
      ..color = segment.color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8.0;

    canvas.drawArc(
        segmentRect, maxFraction + segment.start, segment.size, false, paint);
  }
}
