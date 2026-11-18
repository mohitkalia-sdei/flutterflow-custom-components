import 'dart:math';
import 'package:flutter/material.dart';

/// Custom FlutterFlow Widget: GradientCircularProgress
/// Parameters in FlutterFlow:
/// - width: double
/// - height: double
/// - progress: double (0.0 to 1.0)
/// - startColor: Color
/// - endColor: Color
class GradientCircularProgress extends StatelessWidget {
  final double width;
  final double height;
  final double progress;
  final Color startColor;
  final Color endColor;

  const GradientCircularProgress({
    super.key,
    required this.width,
    required this.height,
    required this.progress,
    this.startColor = Colors.blue,
    this.endColor = Colors.purple,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: CustomPaint(
        painter: _GradientCircularPainter(
          progress: progress.clamp(0.0, 1.0),
          startColor: startColor,
          endColor: endColor,
        ),
        child: Center(
          child: Text(
            '${(progress * 100).toInt()}%',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
      ),
    );
  }
}

class _GradientCircularPainter extends CustomPainter {
  final double progress;
  final Color startColor;
  final Color endColor;

  _GradientCircularPainter({
    required this.progress,
    required this.startColor,
    required this.endColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width, size.height) / 2 - 8;

    // Background circle
    final bgPaint = Paint()
      ..color = Colors.grey.withOpacity(0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8;
    canvas.drawCircle(center, radius, bgPaint);

    // Gradient Progress arc
    final rect = Rect.fromCircle(center: center, radius: radius);
    final gradient = SweepGradient(
      startAngle: -pi / 2,
      endAngle: 3 * pi / 2,
      colors: [startColor, endColor],
    );

    final progressPaint = Paint()
      ..shader = gradient.createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 8;

    final sweepAngle = 2 * pi * progress;
    canvas.drawArc(rect, -pi / 2, sweepAngle, false, progressPaint);
  }

  @override
  bool shouldRepaint(covariant _GradientCircularPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
