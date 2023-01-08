import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' hide Triangle, Colors;

class RemovingSquaresPainter extends CustomPainter {
  const RemovingSquaresPainter({
    required this.steps,
    required this.viewport,
  });

  final int steps;

  final Quad viewport;

  void drawSquare(Rect square, Canvas canvas, int steps) {
    if (square.left < viewport.point0.x || square.right > viewport.point1.x) {
      return;
    }

    final path = Path()
      ..moveTo(square.left, square.top)
      ..lineTo(square.right, square.top)
      ..lineTo(square.right, square.bottom)
      ..lineTo(square.left, square.bottom)
      ..lineTo(square.left, square.top)
      ..close();

    canvas.drawPath(
      path,
      Paint()..color = steps == 0 ? Colors.black : Colors.white,
    );
  }

  void drawSteps(Canvas canvas, int steps, Rect original) {
    if (steps == 0) {
      drawSquare(original, canvas, steps);
      return;
    }

    // 9 congruent squares in the original square
    final m1 = Rect.fromLTRB(
      original.left,
      original.top,
      original.left + original.width / 3,
      original.top + original.height / 3,
    );
    final m2 = Rect.fromLTRB(
      original.left + original.width / 3,
      original.top,
      original.left + 2 * original.width / 3,
      original.top + original.height / 3,
    );
    final m3 = Rect.fromLTRB(
      original.left + 2 * original.width / 3,
      original.top,
      original.right,
      original.top + original.height / 3,
    );
    final m4 = Rect.fromLTRB(
      original.left,
      original.top + original.height / 3,
      original.left + original.width / 3,
      original.top + 2 * original.height / 3,
    );
    final m5 = Rect.fromLTRB(
      original.left + original.width / 3,
      original.top + original.height / 3,
      original.left + 2 * original.width / 3,
      original.top + 2 * original.height / 3,
    );
    final m6 = Rect.fromLTRB(
      original.left + 2 * original.width / 3,
      original.top + original.height / 3,
      original.right,
      original.top + 2 * original.height / 3,
    );
    final m7 = Rect.fromLTRB(
      original.left,
      original.top + 2 * original.height / 3,
      original.left + original.width / 3,
      original.bottom,
    );
    final m8 = Rect.fromLTRB(
      original.left + original.width / 3,
      original.top + 2 * original.height / 3,
      original.left + 2 * original.width / 3,
      original.bottom,
    );
    final m9 = Rect.fromLTRB(
      original.left + 2 * original.width / 3,
      original.top + 2 * original.height / 3,
      original.right,
      original.bottom,
    );

    drawSteps(canvas, steps - 1, m1);
    drawSteps(canvas, steps - 1, m2);
    drawSteps(canvas, steps - 1, m3);
    drawSteps(canvas, steps - 1, m4);
    drawSteps(canvas, steps - 1, m6);
    drawSteps(canvas, steps - 1, m7);
    drawSteps(canvas, steps - 1, m8);
    drawSteps(canvas, steps - 1, m9);
  }

  @override
  void paint(Canvas canvas, Size size) {
    final original = Rect.fromLTRB(
      0,
      0,
      size.width,
      size.height,
    );

    drawSteps(canvas, steps, original);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
