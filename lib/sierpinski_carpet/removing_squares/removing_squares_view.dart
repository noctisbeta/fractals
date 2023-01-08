import 'package:flutter/material.dart';
import 'package:fractals/sierpinski_carpet/removing_squares/removing_squares_painter.dart';

class RemovingSquaresView extends StatefulWidget {
  const RemovingSquaresView({super.key});

  @override
  State<RemovingSquaresView> createState() => _RemovingSquaresViewState();
}

class _RemovingSquaresViewState extends State<RemovingSquaresView> {
  int steps = 0;

  void incrementSteps() {
    if (steps < 11) {
      setState(() {
        steps++;
      });
    }
  }

  void decrementSteps() {
    if (steps > 0) {
      setState(() {
        steps--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Removing Squares'),
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
                      painter: RemovingSquaresPainter(
                        steps: steps,
                        viewport: viewport,
                      ),
                    );
                  },
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
