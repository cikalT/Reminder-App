import 'dart:math';

import 'package:its_reminder_app/utils/app_colors.dart';

import 'clock_text.dart';
import 'package:flutter/material.dart';

class ClockDialPainter extends CustomPainter {
  // ignore: prefer_typing_uninitialized_variables
  final clockText;

  final Paint tickPaint;
  final TextPainter textPainter;
  final TextStyle textStyle;

  final double tickLength = 8.0;
  final double tickWidth = 3.0;
  BuildContext context;

  ClockDialPainter({this.clockText = ClockText.roman, required this.context})
      : tickPaint = Paint(),
        textPainter = TextPainter(
          textAlign: TextAlign.center,
          textDirection: TextDirection.rtl,
        ),
        textStyle = const TextStyle(
          color: AppColors.blackColor,
          fontFamily: 'RobotoMono',
          fontSize: 0.0,
        ) {
    tickPaint.color = AppColors.blackColor;
  }

  @override
  void paint(Canvas canvas, Size size) {
    double tickMarkLength;
    const angle = 2 * pi / 12;

    final radius = size.width / 2;
    canvas.save();

    canvas.translate(radius, radius);
    for (var i = 0; i < 60; i++) {
      tickMarkLength = tickLength;
      tickPaint.strokeWidth = tickWidth;
      canvas.drawLine(Offset(0.0, -radius), Offset(0.0, -radius + tickMarkLength), tickPaint);

      canvas.rotate(angle);
    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
