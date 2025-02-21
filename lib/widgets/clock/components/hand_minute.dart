import 'dart:math';

import 'package:flutter/material.dart';
import 'package:its_reminder_app/utils/app_colors.dart';

class MinuteHandPainter extends CustomPainter {
  final Paint minuteHandPaint;
  int minutes;
  int seconds;

  MinuteHandPainter({required this.minutes, required this.seconds}) : minuteHandPaint = Paint() {
    minuteHandPaint.color = const Color(0xffc5cbdd);
    minuteHandPaint.style = PaintingStyle.stroke;
    minuteHandPaint.strokeCap = StrokeCap.round;
    minuteHandPaint.strokeWidth = 5.0;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final radius = size.width / 2;
    canvas.save();

    canvas.translate(radius, radius);

    canvas.rotate(2 * pi * ((minutes + (seconds / 60)) / 60));

    Path path = Path();
    path.moveTo(0.0, -radius * 0.6);
    path.lineTo(0.0, radius * 0.1);

    path.close();

    canvas.drawPath(path, minuteHandPaint);
    canvas.drawShadow(path, AppColors.blackColor, 4.0, false);

    canvas.restore();
  }

  @override
  bool shouldRepaint(MinuteHandPainter oldDelegate) {
    return true;
  }
}
