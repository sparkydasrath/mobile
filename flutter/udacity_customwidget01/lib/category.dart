import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class Category extends StatelessWidget {
  const Category(
      {Key key,
      @required this.name,
      @required this.color,
      @required this.iconType})
      : assert(name != null),
        assert(color != null),
        assert(iconType != null),
        super(key: key);

  final String name;
  final Color color;
  final IconData iconType;
  final double _height = 100.0;
  final double _borderRadius = 50.0;
  final double _iconSize = 60.0;
  final double _iconPadding = 16.0;
  final double _textSize = 24.0;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
          height: _height,
          padding: EdgeInsets.all(8.0),
          child: InkWell(
            borderRadius: BorderRadius.all(Radius.circular(_borderRadius)),
            highlightColor: color,
            splashColor: color,
            onTap: () => print("inkwell tapped"),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(_iconPadding),
                  child: Icon(
                    iconType,
                    size: _iconSize,
                    color: Colors.blue[200],
                  ),
                ),
                Center(
                  child: Text(
                    this.name,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline,
                  ),
                )
              ],
            ),
          )),
    );
  }
}
