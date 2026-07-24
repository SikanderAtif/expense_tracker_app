import 'package:expense_tracker_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class _CircularPiePainter extends CustomPainter {
  final List<double> values;
  final List<Color> colors;
  final double strokeWidth;

  const _CircularPiePainter ({required this.values, required this.colors, required this.strokeWidth});

  @override
  void paint(Canvas canvas, Size size) {
    final double totalSum = values.fold(0, (sum, item) => sum + item);
    if(totalSum == 0) return;

final Offset center = Offset(size.width / 2, size.height / 2);
    final double radius = (math.min(size.width, size.height) - strokeWidth) / 2;
    final Rect rect = Rect.fromCircle(center: center, radius: radius);

    // Start painting from the top of the circle (-90 degrees)
    double startAngle = -math.pi / 2;

    for (int i = 0; i < values.length; i++) {
      if (values[i] <= 0) continue;

      final double sweepAngle = (values[i] / totalSum) * 2 * math.pi;
      
      final Paint paint = Paint()
        ..color = colors[i % colors.length]
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.butt;

      canvas.drawArc(rect, startAngle, sweepAngle, false, paint);
      startAngle += sweepAngle;
    }
  }

  @override
  bool shouldRepaint(covariant _CircularPiePainter oldDelegate) {
    return oldDelegate.values != values || oldDelegate.colors != colors || oldDelegate.strokeWidth != strokeWidth;
  }
}

class CircularPieIndicator extends StatelessWidget {
  final List<double> data;
  final List<Color> colors;
  final double size;
  final double strokeWidth;
  final TextStyle? textStyle;

  const CircularPieIndicator({
    super.key,
    required this.data,
    required this.colors,
    this.size = 200.0,
    this.strokeWidth = 20.0,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    final double totalSum = data.fold(0, (sum, item) => sum + item);
    final locale = AppLocalizations.of(context)!;

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        children: [
          Positioned.fill(
            child: CustomPaint(
              painter: _CircularPiePainter(
                values: data,
                colors: colors,
                strokeWidth: strokeWidth,
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              '${locale.currency}\n${totalSum.toStringAsFixed(2)}',
              style: textStyle ?? TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}