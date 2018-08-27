import 'package:flutter/material.dart';

class PlatformBackButton extends StatelessWidget {

  PlatformBackButton({VoidCallback onPressed, Color color = const Color(0xFF000000),
    bool isClose = false}) :
        _onPressed = (onPressed == null ? (){} : onPressed),_color = color,
        _isClose = isClose;

  final VoidCallback _onPressed;
  final Color _color;
  final bool _isClose;

  @override
  Widget build(BuildContext context) {
    TargetPlatform targetPlatform = Theme.of(context).platform;
    bool isAndroid = targetPlatform == TargetPlatform.android;
    IconData backIcon = _isClose ? Icons.close : (isAndroid
        ? Icons.arrow_back
        : Icons.arrow_back_ios);
    return new IconButton(
      icon: new Icon(
        backIcon,
        color: _color,
      ),
      onPressed: _onPressed);
  }
}