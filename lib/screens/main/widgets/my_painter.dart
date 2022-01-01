import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();

    paint.color = Colors.amber;
    paint.strokeCap = StrokeCap.square;
    paint.strokeWidth = 6.5;

    // Offset p1 = Offset(50.0, 20.0);
    Offset p1 = const Offset(0.0, 0.0);
    Offset p2 = Offset(size.width, size.height);

    canvas.drawLine(p1, p2, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}