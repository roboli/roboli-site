import 'package:flutter/material.dart';

class Segment {
  const Segment({
    required this.color,
    required this.start,
    required this.size,
    required this.radius,
  });

  final Color color;
  final double start;
  final double size;
  final double radius;
}
