import 'dart:developer';
import 'dart:math' hide log;

import 'package:flutter/material.dart';
import 'package:fractals/sierpinski_triangle/shrinking_and_multiplying/bhtriangle.dart';
import 'package:fractals/sierpinski_triangle/shrinking_and_multiplying/triangle_item.dart';
import 'package:fractals/sierpinski_triangle/shrinking_and_multiplying/triangle_widget.dart';
import 'package:fractals/sierpinski_triangle/triangle.dart';

class ShrinkingAndMultiplyingView extends StatefulWidget {
  const ShrinkingAndMultiplyingView({super.key});

  @override
  State<ShrinkingAndMultiplyingView> createState() =>
      _ShrinkingAndMultiplyingViewState();
}

class _ShrinkingAndMultiplyingViewState
    extends State<ShrinkingAndMultiplyingView> {
  int steps = 1;

  void incrementSteps() {
    if (steps > 10) {
      return;
    }

    steps++;

    final temp = metaTriangleItems.last
        .expand(
          (t) => [
            t.copyWith(
              offset: Offset(
                t.offset.dx,
                t.offset.dy + t.triangle.height / 2,
              ),
            ),
            t.copyWith(
              offset: Offset(
                t.offset.dx + t.triangle.base / 2,
                t.offset.dy + t.triangle.height / 2,
              ),
            ),
            t.copyWith(
              offset: Offset(
                t.offset.dx + t.triangle.base / 4,
                t.offset.dy,
              ),
            ),
          ].map(
            (e) => e.copyWith(
              scale: t.scale / 2,
              triangle: BHTriangle(
                t.triangle.base / 2,
                t.triangle.height / 2,
              ),
            ),
          ),
        )
        .toList();

    metaTriangleItems.add(temp);

    setState(() {});
  }

  void decrementSteps() {
    if (steps < 2) {
      return;
    }
    setState(() {
      metaTriangleItems.removeLast();
      steps--;
    });
  }

  late final initialVertices = [
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

  late final initialTriangle = Triangle(
    initialVertices[0],
    initialVertices[1],
    initialVertices[2],
  );

  late List<TriangleItem> triangleItems = [
    TriangleItem(
      triangle: BHTriangle(
        initialTriangle.baseLength,
        initialTriangle.height,
      ),
      scale: 1,
      offset: Offset.zero,
    ),
  ];

  late final metaTriangleItems = [triangleItems];

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
                child: InteractiveViewer.builder(
                  boundaryMargin: const EdgeInsets.all(10000),
                  maxScale: 100,
                  minScale: 0.001,
                  builder: (context, viewport) {
                    return Stack(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 32,
                          height: MediaQuery.of(context).size.width - 32,
                        ),
                        ...metaTriangleItems.last.map(
                          (e) => AnimatedPositioned(
                            duration: const Duration(milliseconds: 500),
                            left: e.offset.dx,
                            top: e.offset.dy,
                            child: TriangleWidget(
                              originalSize: Size(
                                MediaQuery.of(context).size.width - 32,
                                MediaQuery.of(context).size.width - 32,
                              ),
                              sizeFactor: 1 / pow(2, steps - 1),
                            ),
                          ),
                        ),
                      ],
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
