import 'dart:ui';

import 'package:fractals/sierpinski_triangle/shrinking_and_multiplying/bhtriangle.dart';
import 'package:fractals/sierpinski_triangle/triangle.dart';

class TriangleItem {
  TriangleItem({
    required this.triangle,
    required this.scale,
    required this.offset,
  });

  final BHTriangle triangle;
  final double scale;
  final Offset offset;

  TriangleItem copyWith({
    BHTriangle? triangle,
    double? scale,
    Offset? offset,
  }) {
    return TriangleItem(
      triangle: triangle ?? this.triangle,
      scale: scale ?? this.scale,
      offset: offset ?? this.offset,
    );
  }
}
