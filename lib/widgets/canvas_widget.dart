import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class CanvasWidget extends StatefulWidget {
  CanvasWidget({Key key}) : super(key: key);

  @override
  _CanvasWidgetState createState() => _CanvasWidgetState();
}

class _CanvasWidgetState extends State<CanvasWidget> with AutomaticKeepAliveClientMixin {
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
    super.build(context);
    return CustomPaint(
      painter: _wavePainter,
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class TestingPainter extends CustomPainter {
  static const double _numberPixelsToDraw = 3;
  final _rng = Random();
  final _paint = Paint();

  List<double> _pointsToDraw = <double>[];
  int _currentIndex = 0;

  TestingPainter({Listenable repaint}) : super(repaint: repaint) {
    _paint.color = Colors.green;
    _paint.style = PaintingStyle.stroke;
  }

  @override
  Future<void> paint(Canvas canvas, Size size) async {
    if (_pointsToDraw.length != size.width.toInt()) {
      _pointsToDraw = List.filled(size.width.toInt(), -1);
      _currentIndex = 0;
    }

    // Add new points to draw
    for (int i = 0; i < _numberPixelsToDraw; i++) {
      if (_currentIndex >= _pointsToDraw.length) {
        _currentIndex = 0;
      }
      _pointsToDraw[_currentIndex] = _rng.nextDouble() * size.height;
      _currentIndex++;
    }

    var path = Path();
    for (int i = 0; i < _pointsToDraw.length; i++) {
      var point = _pointsToDraw[i];
      if (point < 0) {
        break;
      }

      if (i == 0) {
        path.moveTo(0, point);
      } else {
        path.lineTo(i.toDouble(), point);
      }
    }

    canvas.drawPath(path, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
