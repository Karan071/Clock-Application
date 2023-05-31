import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class ClockView extends StatefulWidget {
  final double size;

  const ClockView({super.key, required this.size});

  @override
  State<ClockView> createState() => _ClockViewState();
}

class _ClockViewState extends State<ClockView> {
  @override
  void initState() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.size,
      height: widget.size,
      child: Transform.rotate(
        angle: -pi / 2,
        child: CustomPaint(
          painter: ClockPainter(),
        ),
      ),
    );
  }
}

class ClockPainter extends CustomPainter {
  var dateTime = DateTime.now();
  //60 sec - 360, 1 sec - 6 degree
  //12 hours - 360 1 hour - 30 degree, 1 min - 0.5degree
  @override
  void paint(Canvas canvas, Size size) {
    var centerX = size.width / 2; //center point in x axis
    var centerY = size.width / 2; //center point in y axis
    var center = Offset(centerX, centerY); //center point
    var radius = min(centerX, centerY);

    var fillBrush = Paint()..color = Color(0xFF444974);
    //outline boundary
    var outlineBrush = Paint()
      ..color = Color(0xFFEAECFF)
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width / 20;

    //
    var centerFillBrush = Paint()
      ..color = Color(0xFFEAECFF)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 16;

    var centreFillBrush = Paint()..color = Color(0xFFEAECFF);

    var secHandBrush = Paint()
      ..color = Colors.orange[300]!
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = size.width / 60;

    var minHandBrush = Paint()
      ..shader = RadialGradient(colors: [Color(0xFF748EF6), Color(0xFF77DDFF)])
          .createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width / 30
      ..strokeCap = StrokeCap.round;

    var hourHandBrush = Paint()
      ..shader = RadialGradient(colors: [Color(0xFFEA74AB), Color(0xFFC279FB)])
          .createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = size.width / 24;

    var dashBrush = Paint()
      ..color = Color(0xFFEAECFF)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 3;

    canvas.drawCircle(center, radius * 0.75, fillBrush);
    canvas.drawCircle(center, radius * 0.75, outlineBrush);

    var secHandX =
        centerX + radius * 0.75 * cos(dateTime.second * 6 * pi / 180);
    var secHandY =
        centerX + radius * 0.75 * sin(dateTime.second * 6 * pi / 180);
    canvas.drawLine(center, Offset(secHandX, secHandY), secHandBrush);

    var minHandX = centerX + radius * 0.6 * cos(dateTime.minute * 6 * pi / 180);
    var minHandY = centerX + radius * 0.6 * sin(dateTime.minute * 6 * pi / 180);
    canvas.drawLine(center, Offset(minHandX, minHandY), minHandBrush);

    var hourHandX = centerX +
        radius *
            0.4 *
            cos((dateTime.hour * 30 + dateTime.minute * 0.5) * pi / 180);
    var hourHandY = centerX +
        radius *
            0.4 *
            sin((dateTime.hour * 30 + dateTime.minute * 0.5) * pi / 180);
    canvas.drawLine(center, Offset(hourHandX, hourHandY), hourHandBrush);

    canvas.drawCircle(center, radius * 0.12,
        centerFillBrush); //center dot//position should be last

    var outCircleRadius = radius;
    var innerCircleRadius = radius * 0.9;
    for (double i = 0; i < 360; i += 12) {
      var x1 = centerX + outCircleRadius * cos(i * pi / 180);
      var y1 = centerX + outCircleRadius * sin(i * pi / 180);

      var x2 = centerX + outCircleRadius * cos(i * pi / 180);
      var y2 = centerX + outCircleRadius * sin(i * pi / 180);
      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), dashBrush);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
