// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:math' as math;

import 'dart:math';
import 'package:flutter/widgets.dart';

enum PainterStartPosition {
  topLeft,
  topCenter,
  topRight,
  centerLeft,
  center,
  centerRight,
  bottomLeft,
  bottomCenter,
  bottomRight,
}

class CircularReveal extends StatefulWidget {
  CircularReveal({
    Color color,
    Duration duration,
    PainterStartPosition startPosition,
  })
      : _color = color,
        _duration = duration,
        _startPosition = startPosition;

  final Color _color;
  final Duration _duration;
  final PainterStartPosition _startPosition;

  @override
  _CircularRevealState createState() =>
      new _CircularRevealState(color: _color, duration: _duration, startPosition: _startPosition);
}

class _CircularRevealState extends State<CircularReveal> with SingleTickerProviderStateMixin {
  _CircularRevealState({
    Color color,
    Duration duration,
    PainterStartPosition startPosition,
  })
      : _color = color,
        _duration = duration,
        _startPosition = startPosition;

  final Color _color;
  final Duration _duration;
  final PainterStartPosition _startPosition;

  AnimationController _animation;
  Tween<double> _tween;

  @override
  void initState() {
    super.initState();
    _animation = new AnimationController(
        vsync: this,
        duration: _duration,
    );
    _animation.forward();
  }

  @override
  void dispose() {
    _animation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double offsetWindowHeight = MediaQuery.of(context).size.height / 2.0;
    final double offsetWindowWidth = MediaQuery.of(context).size.width / 2.0;
    final double radius = math.sqrt(math.pow(offsetWindowHeight * 2, 2) + math.pow(offsetWindowWidth * 2, 2));
    _tween = new Tween<double>(
        begin: 0.0,
        end: radius,
    );
    Offset origin;
    // TODO(al) - investigate if circle origin is correct
    if (_startPosition == PainterStartPosition.topLeft) {
      origin = new Offset(-offsetWindowWidth, -offsetWindowHeight);
    } else if (_startPosition == PainterStartPosition.topCenter) {
      origin = new Offset(0.0, -offsetWindowHeight);
    } else if (_startPosition == PainterStartPosition.topRight) {
      origin = new Offset(offsetWindowWidth, offsetWindowHeight);
    } else if (_startPosition == PainterStartPosition.centerLeft) {
      origin = new Offset(-offsetWindowWidth, 0.0);
    } else if (_startPosition == PainterStartPosition.center) {
      origin = new Offset(0.0, 0.0);
    } else if (_startPosition == PainterStartPosition.centerRight) {
      origin = new Offset(offsetWindowWidth, 0.0);
    } else if (_startPosition == PainterStartPosition.bottomLeft) {
      origin = new Offset(-offsetWindowWidth, offsetWindowHeight);
    } else if (_startPosition == PainterStartPosition.bottomRight) {
      origin = new Offset(offsetWindowWidth, offsetWindowHeight);
    }
    return new CustomPaint(
        painter: new CirclePainter(animation: _tween.animate(_animation), color: _color, origin: origin),
    );
  }
}

class CirclePainter extends CustomPainter {
  CirclePainter({
    Animation<double> animation,
    Color color,
    Offset origin,
  })
      : _animation = animation,
        _color = color,
        _origin = origin,
        super(repaint: animation);

  final Animation<double> _animation;
  final Color _color;
  final Offset _origin;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = new Paint()
      ..color = _color
      ..style = PaintingStyle.fill;

//    canvas.drawCircle(_origin, _animation.value, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
