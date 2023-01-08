import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' hide Colors;

class ChaosGamePainter extends CustomPainter {
  ChaosGamePainter({
    required this.viewport,
    required this.points,
  });

  final Quad viewport;

  final List<Offset> points;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2;

    canvas.drawPoints(PointMode.points, points..add(points[0]), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
