import 'package:flutter/material.dart';
import 'package:fractals/sierpinski_triangle.dart';

void main() {
  runApp(
    const MaterialApp(
      home: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
