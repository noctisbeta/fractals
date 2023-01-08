import 'package:flutter/material.dart';

class TriangleWidget extends StatelessWidget {
  const TriangleWidget({
    required this.sizeFactor,
    required this.originalSize,
    super.key,
  });

  final double sizeFactor;

  final Size originalSize;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: originalSize.width * sizeFactor,
      height: originalSize.height * sizeFactor,
      child: CustomPaint(
        painter: TrianglePainter(),
      ),
    );
  }
}

class TrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 1
      ..strokeCap = StrokeCap.round;

    final path = Path()
      ..moveTo(size.width / 2, 0)
      ..lineTo(0, size.width)
      ..lineTo(size.width, size.width)
      ..lineTo(size.width / 2, 0)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
