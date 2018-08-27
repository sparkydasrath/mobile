import 'package:flutter/material.dart';
import 'package:flutter/src/services/system_chrome.dart';
import 'package:posse_gallery/config/application.dart';
import 'package:posse_gallery/notifications/notifications.dart';
import 'package:posse_gallery/views/platform_back_button.dart';

class DebugToggleItem extends StatelessWidget {

  DebugToggleItem({this.debugKey, this.isSelected, this.text, ValueChanged<bool> valueChanged}) :
    _valueChanged = valueChanged;

  bool isSelected = false;
  String debugKey;
  String text;
  ValueChanged<bool> _valueChanged;

  @override
  Widget build(BuildContext context) {
    return new ConstrainedBox(
      constraints: new BoxConstraints.expand(height: 60.0),
      child: new Padding(
        padding: new EdgeInsets.only(left: 20.0, right: 50.0),
        child: new Row(
          children: [
            new Checkbox(
              value: isSelected,
              onChanged: _valueChanged,
            ),
            new Expanded(
              child: new Padding(
                padding: new EdgeInsets.only(left: 12.0),
                child: new Text(text),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DebugOptionsScreen extends StatefulWidget {

  @override
  State createState() => new _DebugOptionsScreenState();
}

class _DebugOptionsScreenState extends State<DebugOptionsScreen> {

  Map<String, bool> selectedOptions = <String, bool>{};

  Widget _debugToggleRow(String debugKey, String text, bool isSelected) {
    return new DebugToggleItem(text: text, isSelected: isSelected, valueChanged: (checked) {
      setState((){
        _setSelectedStateForKey(debugKey, checked);
      });
    });
  }

  bool _selectedStateForKey(String key) {
    bool defaultValue = false;
    if (key == "perf-overlay") {
      defaultValue = Application.enablePerformanceOverlay;
    } else if (key == "checkerboard-images") {
      defaultValue = Application.checkerboardRasterCacheImages;
    }
    bool isSelected = selectedOptions[key];
    return isSelected != null ? isSelected : defaultValue;
  }

  void _setSelectedStateForKey(String key, bool isSelected) {
    selectedOptions[key] = isSelected;
    if (key == "perf-overlay") {
      Application.enablePerformanceOverlay = isSelected;
    } else if (key == "checkerboard-images") {
      Application.checkerboardRasterCacheImages = isSelected;
    }
    DebugOptionChangedNotification notification = new DebugOptionChangedNotification();
    notification.dispatch(context);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return new Material(
      color: new Color(0xFFFFFFFF),
      child: new Column(
        children: <Widget>[
          new AppBar(
            backgroundColor: new Color(0xFFDDDDDD),
            title: new Text(
              "Debug",
              style: new TextStyle(
                color: new Color(0xFF777777),
              ),
            ),
            leading: new PlatformBackButton(
              isClose: true,
              color: new Color(0xFF777777),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          new Padding(
            padding: new EdgeInsets.only(top: 20.0),
            child: _debugToggleRow("perf-overlay", "Turns on the performance overlay",
                _selectedStateForKey("perf-overlay")),
          ),
          _debugToggleRow("checkerboard-images", "Turn on checkerboarding of raster cache images",
              _selectedStateForKey("checkerboard-images")),
        ],
      ),
    );
  }
}