import 'package:flutter/material.dart';
import 'package:fractals/sierpinski_triangle/removing_triangles_painter.dart';

class RemovingTrianglesView extends StatefulWidget {
  const RemovingTrianglesView({super.key});

  @override
  State<RemovingTrianglesView> createState() => _RemovingTrianglesViewState();
}

class _RemovingTrianglesViewState extends State<RemovingTrianglesView> {
  int steps = 1;

  void incrementSteps() {
    if (steps < 10) {
      setState(() {
        steps++;
      });
    }
  }

  void decrementSteps() {
    if (steps > 1) {
      setState(() {
        steps--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Removing Triangles'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 16),
              Text(
                'Steps: $steps',
                style: const TextStyle(
                  fontSize: 30,
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: InteractiveViewer(
                  maxScale: 100,
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: CustomPaint(
                      painter: RemovingTrianglesPainter(
                        steps: steps,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FloatingActionButton(
                    heroTag: null,
                    onPressed: decrementSteps,
                    child: const Icon(Icons.remove),
                  ),
                  const SizedBox(width: 16),
                  FloatingActionButton(
                    heroTag: null,
                    onPressed: incrementSteps,
                    child: const Icon(Icons.add),
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
