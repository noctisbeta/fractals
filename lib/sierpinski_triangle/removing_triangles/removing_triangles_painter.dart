import 'package:flutter/material.dart';
import 'package:fractals/sierpinski_triangle/triangle.dart';
import 'package:vector_math/vector_math_64.dart' hide Triangle, Colors;

class RemovingTrianglesPainter extends CustomPainter {
  const RemovingTrianglesPainter({
    required this.steps,
    required this.viewport,
  });

  final int steps;

  final Quad viewport;

  void drawTriangle(Triangle triangle, Canvas canvas, int steps) {
    if (triangle.c.dx < viewport.point0.x ||
        triangle.b.dx > viewport.point1.x) {
      return;
    }

    final path = Path()
      ..moveTo(triangle.a.dx, triangle.a.dy)
      ..lineTo(triangle.b.dx, triangle.b.dy)
      ..lineTo(triangle.c.dx, triangle.c.dy)
      ..lineTo(triangle.a.dx, triangle.a.dy)
      ..close();

    canvas.drawPath(
      path,
      Paint()..color = steps == 1 ? Colors.black : Colors.white,
    );
  }

  void drawSteps(Canvas canvas, int steps, Triangle original) {
    if (steps == 1) {
      drawTriangle(original, canvas, steps);
      return;
    }

    final m1 = Offset.lerp(original.a, original.b, 0.5)!;
    final m2 = Offset.lerp(original.b, original.c, 0.5)!;
    final m3 = Offset.lerp(original.c, original.a, 0.5)!;

    final triangle = Triangle(m1, m2, m3);

    drawTriangle(triangle, canvas, steps);

    final t1 = Triangle(original.a, m1, m3);
    final t2 = Triangle(m1, original.b, m2);
    final t3 = Triangle(m3, m2, original.c);

    drawSteps(canvas, steps - 1, t1);
    drawSteps(canvas, steps - 1, t2);
    drawSteps(canvas, steps - 1, t3);
  }

  @override
  void paint(Canvas canvas, Size size) {
    final original = Triangle(
      Offset(size.width / 2, 0),
      Offset(0, size.height),
      Offset(size.width, size.height),
    );

    drawSteps(canvas, steps, original);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
