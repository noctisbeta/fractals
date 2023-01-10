import 'dart:async';
import 'dart:developer';
import 'dart:math' hide log;

import 'package:flutter/material.dart';
import 'package:fractals/sierpinski_triangle/chaos_game/chaos_game_painter.dart';

class CarpetChaosGameView extends StatefulWidget {
  const CarpetChaosGameView({super.key});

  @override
  State<CarpetChaosGameView> createState() => _CarpetChaosGameViewState();
}

class _CarpetChaosGameViewState extends State<CarpetChaosGameView> {
  late List<Offset> vertices = List.unmodifiable([
    Offset.zero,
    Offset(
      (MediaQuery.of(context).size.width - 32) / 2,
      0,
    ),
    Offset(
      (MediaQuery.of(context).size.width - 32) / 2,
      MediaQuery.of(context).size.width - 32,
    ),
    Offset(
      MediaQuery.of(context).size.width - 32,
      (MediaQuery.of(context).size.width - 32) / 2,
    ),
    Offset(
      MediaQuery.of(context).size.width - 32,
      MediaQuery.of(context).size.width - 32,
    ),
    Offset(
      MediaQuery.of(context).size.width - 32,
      0,
    ),
    Offset(
      0,
      MediaQuery.of(context).size.width - 32,
    ),
    Offset(
      0,
      (MediaQuery.of(context).size.width - 32) / 2,
    ),
  ]);

  late final List<Offset> points = List.from(vertices);

  Timer? timer;

  Offset randomInsideSquare() {
    final random = Random(
      DateTime.now().millisecondsSinceEpoch,
    );
    final r1 = random.nextDouble();
    final r2 = random.nextDouble();

    final length = MediaQuery.of(context).size.width - 32;

    return Offset(r1, r2) * length;
  }

  void start() {
    log('vertices: ${vertices.length}');
    log('points: ${points.length}');

    if (points.length == 8) {
      log('HERE');
      final randomPoint = randomInsideSquare();
      setState(() {
        points.add(randomPoint);
      });
    }

    timer = Timer.periodic(const Duration(milliseconds: 1), (timer) {
      if (points.length > 100000) {
        timer.cancel();
      }

      final random = Random(
        DateTime.now().millisecondsSinceEpoch,
      );

      final index = random.nextInt(8);
      final vertex = vertices[index];

      final randomPoint = randomInsideSquare();

      final newPoint = Offset(
            points.last.dx + 2 * vertex.dx,
            points.last.dy + 2 * vertex.dy,
          ) *
          1 /
          3;

      // final newPoint = Offset(
      //       (points.last.dx - randomPoint.dx).abs(),
      //       (points.last.dy - randomPoint.dy).abs(),
      //     ) *
      //     2 /
      //     3;

      // final newPoint = Offset(
      //       points.last.dx + randomPoint.dx,
      //       points.last.dy + randomPoint.dy,
      //     ) *
      //     2 /
      //     3;

      setState(() {
        points.add(newPoint);
      });
    });
  }

  void toggle() {
    log('inside toggle');
    if (timer?.isActive ?? false) {
      log('cancelling');
      timer?.cancel();
    } else {
      log('starting');
      start();
    }
  }

  @override
  void didChangeDependencies() {
    log('didchange');
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    log('rebuild');
    log('points in build: ${points.length}');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chaos Game'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: null,
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
