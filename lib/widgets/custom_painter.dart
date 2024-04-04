import 'dart:math' as math;

import 'package:flutter/material.dart';

class CustomLoadingIndicator extends StatelessWidget {
  const CustomLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _LoadingIndicatorPainter(),
    );
  }
}

class _LoadingIndicatorPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    const double radius = 12;
    final Offset center = Offset(size.width / 2, size.height / 2);

    const double offset = 10;
    const double indicatorLength = 8;
    
    final double rotationAngle =
        2 * math.pi * DateTime.now().millisecond / 1000;

    for (double angle = 0; angle < 360; angle += 45) {
      final double radians = angle * math.pi / 180 + rotationAngle;
      final double startX = center.dx + (radius - offset) * math.cos(radians);
      final double startY = center.dy + (radius - offset) * math.sin(radians);
      final double endX =
          center.dx + (radius + indicatorLength) * math.cos(radians);
      final double endY =
          center.dy + (radius + indicatorLength) * math.sin(radians);

      canvas.drawLine(Offset(startX, startY), Offset(endX, endY), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
