import 'hand_hour.dart';
import 'hand_minute.dart';
import 'hand_second.dart';
import 'package:flutter/material.dart';

class ClockHands extends StatelessWidget {
  final DateTime dateTime;
  final bool showHourHandleHeartShape;

  const ClockHands({super.key, required this.dateTime, this.showHourHandleHeartShape = false});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.0,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20.0),
        child: Stack(fit: StackFit.expand, children: [
          CustomPaint(
            painter: HourHandPainter(hours: dateTime.hour, minutes: dateTime.minute),
          ),
          CustomPaint(
            painter: MinuteHandPainter(minutes: dateTime.minute, seconds: dateTime.second),
          ),
          CustomPaint(
            painter: SecondHandPainter(seconds: dateTime.second),
          ),
        ]),
      ),
    );
  }
}
