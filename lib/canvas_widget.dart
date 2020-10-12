import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class CanvasWidget extends StatefulWidget {
  CanvasWidget({Key key}) : super(key: key);

  @override
  _CanvasWidgetState createState() => _CanvasWidgetState();
}

class _CanvasWidgetState extends State<CanvasWidget> {
  final _repaint = ValueNotifier<int>(0);
  TestingPainter _wavePainter;

  @override
  void initState() {
    _wavePainter = TestingPainter(repaint: _repaint);
    Timer.periodic(Duration(milliseconds: 40), (Timer timer) {
      _repaint.value++;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _wavePainter,
    );
  }
}

class TestingPainter extends CustomPainter {
  static const double _numberPixelsToDraw = 3;
  final _rng = Random();

  List<double> _pointsToDraw = List<double>();
  int _currentIndex = 0;

  TestingPainter({Listenable repaint}) : super(repaint: repaint);

  @override
  void paint(Canvas canvas, Size size) {
    if (_pointsToDraw.length != size.width.toInt()) {
      _pointsToDraw = List.filled(size.width.toInt(), -1);
      _currentIndex = 0;
    }

    // Add new points to draw
    for (int i = 0; i < _numberPixelsToDraw; i++) {
      if (_currentIndex >= _pointsToDraw.length) {
        _currentIndex = 0;
      }
      _pointsToDraw[_currentIndex] = _rng.nextInt(size.height.toInt()).toDouble();
      _currentIndex++;
    }

    var paint = Paint();
    paint.color = Colors.green;

    double previousPoint = _pointsToDraw.first;
    for (int i = 1; i < _pointsToDraw.length; i++) {
      var point = _pointsToDraw[i];
      if (point < 0) {
        break;
      }
      canvas.drawLine(
          Offset((i - 1).toDouble(), previousPoint), Offset(i.toDouble(), point), paint);
      previousPoint = point;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
