import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CustomPaint(
          size: const Size(300, 300),
          painter: SierpinskiTrianglePainter(),
        ),
      ),
    );
  }
}

class SierpinskiTrianglePainter extends CustomPainter {
  static final brush = Paint()
    ..color = Colors.black
    ..strokeWidth = 1
    ..style = PaintingStyle.stroke;

  void drawTriangle(Triangle triangle, Canvas canvas) {
    final path = Path()
      ..moveTo(triangle.a.dx, triangle.a.dy)
      ..lineTo(triangle.b.dx, triangle.b.dy)
      ..lineTo(triangle.c.dx, triangle.c.dy)
      ..lineTo(triangle.a.dx, triangle.a.dy);

    canvas.drawPath(path, brush);
  }

  void drawSteps(Canvas canvas, int steps, Triangle original) {
    if (steps == 1) {
      drawTriangle(original, canvas);
      return;
    }

    final m1 = Offset.lerp(original.a, original.b, 0.5)!;
    final m2 = Offset.lerp(original.b, original.c, 0.5)!;
    final m3 = Offset.lerp(original.c, original.a, 0.5)!;

    final triangle = Triangle(m1, m2, m3);

    drawTriangle(triangle, canvas);

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

    drawSteps(canvas, 8, original);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class Triangle {
  final Offset a;
  final Offset b;
  final Offset c;

  Triangle(this.a, this.b, this.c);
}
