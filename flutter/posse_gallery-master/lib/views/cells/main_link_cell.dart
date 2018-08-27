import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MainLinkCell extends StatelessWidget {

  MainLinkCell(String title, String subtitle, String iconAssetPath, {@required GestureTapCallback tapped})
      :
        this._title = title,
        this._subtitle = subtitle,
        this._iconAssetPath = iconAssetPath,
        this._tapCallback = tapped;

  final String _title;
  final String _subtitle;
  final String _iconAssetPath;
  final GestureTapCallback _tapCallback;

  @override
  Widget build(BuildContext context) {
    return new Material(
      color: new Color(0x00FFFFFF),
      child: new Padding(
        padding: new EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0, bottom: 8.0),
        child: new InkWell(
          onTap: _tapCallback,
          child: new ConstrainedBox(
            constraints: new BoxConstraints.expand(
              height: 70.0,
            ),
            child: new Center(
              child: new Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  new Padding(
                      padding: new EdgeInsets.only(left: 20.0),
                      child: new Image(
                        image: new AssetImage(_iconAssetPath),
                        width: 40.0,
                        height: 40.0,
                      )
                  ),
                  new Expanded(
                    child: new Padding(
                      padding: new EdgeInsets.only(left: 15.0),
                      child: new Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          new Text(
                            _title,
                            style: new TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          new Padding(
                            padding: new EdgeInsets.only(top: 5.0, right: 20.0),
                            child: new Text(
                              _subtitle,
                              maxLines: 2,
                              textAlign: TextAlign.left,
                              style: new TextStyle(
                                fontSize: 12.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}