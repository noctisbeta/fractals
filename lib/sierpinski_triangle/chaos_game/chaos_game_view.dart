import 'dart:async';
import 'dart:developer';
import 'dart:math' hide log;

import 'package:flutter/material.dart';
import 'package:fractals/sierpinski_triangle/chaos_game/chaos_game_painter.dart';
import 'package:fractals/sierpinski_triangle/removing_triangles/removing_triangles_painter.dart';

class ChaosGameView extends StatefulWidget {
  const ChaosGameView({super.key});

  @override
  State<ChaosGameView> createState() => _ChaosGameViewState();
}

class _ChaosGameViewState extends State<ChaosGameView> {
  late final vertices = [
    Offset(
      (MediaQuery.of(context).size.width - 32) / 2,
      0,
    ),
    Offset(
      0,
      MediaQuery.of(context).size.width - 32,
    ),
    Offset(
      MediaQuery.of(context).size.width - 32,
      MediaQuery.of(context).size.width - 32,
    ),
  ];

  late final points = [...vertices];

  Timer? timer;

  Offset randomInsideTriangle() {
    final random = Random();

    final r1 = random.nextDouble();
    final r2 = random.nextDouble();

    final x = (1 - sqrt(r1)) * vertices[0].dx +
        (sqrt(r1) * (1 - r2)) * vertices[1].dx +
        (sqrt(r1) * r2) * vertices[2].dx;
    final y = (1 - sqrt(r1)) * vertices[0].dy +
        (sqrt(r1) * (1 - r2)) * vertices[1].dy +
        (sqrt(r1) * r2) * vertices[2].dy;

    return Offset(x, y);
  }

  void start() {
    timer = Timer.periodic(const Duration(milliseconds: 1), (timer) {
      if (points.length > 100000) {
        timer.cancel();
      }

      final random = Random(
        DateTime.now().millisecondsSinceEpoch,
      );

      final index = random.nextInt(3);
      final vertex = vertices[index];

      final randomPoint = randomInsideTriangle();

      if (points.length == 3) {
        setState(() {
          points.add(randomPoint);
        });

        return;
      }

      final newPoint = Offset(
        (points.last.dx + vertex.dx) / 2,
        (points.last.dy + vertex.dy) / 2,
      );

      log('newPoint: $newPoint');

      setState(() {
        points.add(newPoint);
      });

      log('points: ${points.length}');
    });
  }

  void toggle() {
    if (timer?.isActive ?? false) {
      timer?.cancel();
    } else {
      start();
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chaos Game'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: toggle,
        child: Icon(
          timer?.isActive ?? false ? Icons.stop : Icons.play_arrow,
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 16),
              Text(
                'Points: ${points.length}',
                style: const TextStyle(
                  fontSize: 30,
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: InteractiveViewer.builder(
                  boundaryMargin: const EdgeInsets.all(10000),
                  maxScale: 100,
                  minScale: 0.001,
                  builder: (context, viewport) {
                    return CustomPaint(
                      size: Size(
                        MediaQuery.of(context).size.width - 32,
                        MediaQuery.of(context).size.width - 32,
                      ),
                      isComplex: true,
                      willChange: true,
                      painter: ChaosGamePainter(
                        viewport: viewport,
                        points: points,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
