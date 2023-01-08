// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';

class Triangle {
  const Triangle(this.a, this.b, this.c);

  final Offset a;
  final Offset b;
  final Offset c;

  double get height => c.dy - a.dy;

  double get baseLength => c.dx - b.dx;
}
