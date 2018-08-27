// ignore: invalid_constant
// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/src/cupertino/dialog.dart';
import 'package:meta/meta.dart';
import 'package:posse_gallery/screens/demos/platform_demo_detail.dart';

class PlatformDemo extends StatefulWidget {
  @override
  PlatformDemoState createState() => new PlatformDemoState();
}

class PlatformDemoState extends State<PlatformDemo>
    with TickerProviderStateMixin {
  static const int _kAnimationInDuration = 400;

  TargetPlatform _targetPlatform;
  TextAlign _platformTextAlignment;
  ThemeData _themeData;

  int _radioValue = 0;
  Animation<double> _fadeInAnimation;
  Animation<Offset> _leftPaneAnimation;
  Animation<Offset> _rightPaneAnimation;
  Animation<double> _scaleInAnimation;
  Animation<double> _pivotCounterClockwiseAnimation;
  Animation<double> _pivotClockwiseAnimation;

  AnimationController _animationController;
  AnimationController _leftPaneAnimationController;
  AnimationController _rightPaneAnimationController;

  String _heroImageString;

  @override
  Widget build(BuildContext context) {
    _heroImageString = "assets/images/platform_hero.png";
    _configureThemes();
    _buildBottomSheet();
    return new Theme(
      data: _themeData,
      child: new Material(
        color: _themeData.primaryColor,
        child: _contentWidget(),
      ),
    );
  }

  @override
  dispose() {
    _animationController.dispose();
    _leftPaneAnimationController.dispose();
    _rightPaneAnimationController.dispose();
    super.dispose();
  }

  @override
  initState() {
    super.initState();
    _configureAnimation();
    _animationController.forward();
    _leftPaneAnimationController.forward();
    _rightPaneAnimationController.forward();
  }

  Widget _buildAppBar() {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    return new Container(
      height: 80.0,
      padding: new EdgeInsets.only(top: statusBarHeight),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          new BackButton(),
          new Expanded(
            child: new Text(
              "Modern Furniture",
              style: new TextStyle(
                color: _themeData.textTheme.title.color,
                fontWeight: FontWeight.w500,
                fontSize: 20.0,
              ),
              textAlign: _platformTextAlignment,
            ),
          ),
          new IconButton(
            icon: new Icon(
              Icons.more_vert,
              color: _themeData.iconTheme.color,
            ),
            onPressed: () {
              showModalBottomSheet<Null>(
                context: context,
                builder: (BuildContext context) {
                  return _buildBottomSheet();
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return new Expanded(
      child: new FadeTransition(
        opacity: _fadeInAnimation,
        child: new Container(
          child: new Column(
            children: [
              _buildHeroWidget(),
              _buildBottomPanes(),
            ],
          ),
        ),
      ),
    );
  }

  List<BottomNavigationBarItem> _buildBottomNavBar() {
    List<BottomNavigationBarItem> buttons = [];
    final homeButton = new BottomNavigationBarItem(
      icon: new Icon(Icons.home, color: Colors.black),
      title: const Text(""),
    );
    final flashButton = new BottomNavigationBarItem(
      icon: new Icon(Icons.flash_on, color: Colors.black),
      title: const Text(""),
    );
    final cartButton = new BottomNavigationBarItem(
      icon: new Icon(Icons.shopping_cart, color: Colors.black),
      title: const Text(""),
    );
    final profileButton = new BottomNavigationBarItem(
      icon: new Icon(Icons.person, color: Colors.black),
      title: const Text(""),
    );
    buttons.add(homeButton);
    buttons.add(flashButton);
    buttons.add(cartButton);
    buttons.add(profileButton);
    return buttons;
  }

  Widget _buildBottomPanes() {
    FractionalOffset itemTextFractionalOffset =
        _targetPlatform == TargetPlatform.android
            ? FractionalOffset.bottomLeft
            : FractionalOffset.center;
    TextAlign itemTextAlignment = _targetPlatform == TargetPlatform.android
        ? TextAlign.left
        : TextAlign.center;
    return new Row(
      children: [
        new SlideTransition(
          position: _leftPaneAnimation,
          child: new GestureDetector(
            onTap: (() {
              if (_targetPlatform == TargetPlatform.iOS) {
                showDemoDialog(
                  context: context,
                  child: new CupertinoAlertDialog(
                      title: const Text('Coming Soon'),
                      content: const Text('The Wall Lamp'),
                      actions: <Widget>[
                        new CupertinoDialogAction(
                            child: const Text('Keep Shopping',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600)),
                            onPressed: () {
                              Navigator.pop(context, 'Keep Shopping');
                            }),
                      ]),
                );
              } else if (_targetPlatform == TargetPlatform.android) {
                showDialog(
                  context: context,
                  child: new AlertDialog(
                      title: const Text('Coming Soon'),
                      content: new Text('The Wall Lamp'),
                      actions: <Widget>[
                        new FlatButton(
                            child: const Text('OK'),
                            onPressed: () {
                              Navigator.pop(context, false);
                            }),
                      ]),
                );
              }
            }),
            child: new Container(
              child: new Stack(
                children: [
                  new Image(
                    width: MediaQuery.of(context).size.width * 0.5,
                    image: new AssetImage("assets/images/platform_lamp.png"),
                  ),
                  new Positioned.fill(
                    child: new Container(
                      color: const Color(0x40333333),
                    ),
                  ),
                  new Positioned(
                    left: 10.0,
                    top: 0.0,
                    right: 0.0,
                    bottom: 12.0,
                    child: new Align(
                      alignment: itemTextFractionalOffset,
                      child: new Text(
                        "THE\nWALL LAMP",
                        textAlign: itemTextAlignment,
                        style: new TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          height: 1.3,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        new GestureDetector(
          onTap: (() {
            if (_targetPlatform == TargetPlatform.iOS) {
              showDemoDialog(
                context: context,
                child: new CupertinoAlertDialog(
                    title: const Text('Coming Soon'),
                    content: const Text('Natural Side Table'),
                    actions: <Widget>[
                      new CupertinoDialogAction(
                          child: const Text('Keep Shopping',
                              style:
                                  const TextStyle(fontWeight: FontWeight.w600)),
                          onPressed: () {
                            Navigator.pop(context, 'Keep Shopping');
                          }),
                    ]),
              );
            } else if (_targetPlatform == TargetPlatform.android) {
              showDialog(
                context: context,
                child: new AlertDialog(
                    title: const Text('Coming Soon'),
                    content: new Text('Natural Side Table'),
                    actions: <Widget>[
                      new FlatButton(
                          child: const Text('OK'),
                          onPressed: () {
                            Navigator.pop(context, false);
                          }),
                    ]),
              );
            }
          }),
          child: new SlideTransition(
            position: _rightPaneAnimation,
            child: new Container(
              child: new Stack(
                children: [
                  new Image(
                    width: MediaQuery.of(context).size.width * 0.5,
                    image: new AssetImage("assets/images/platform_table.png"),
                  ),
                  new Positioned.fill(
                    child: new Container(
                      color: const Color(0x40333333),
                    ),
                  ),
                  new Positioned(
                    left: 10.0,
                    top: 0.0,
                    right: 0.0,
                    bottom: 12.0,
                    child: new Align(
                      alignment: itemTextFractionalOffset,
                      child: new Text(
                        "NATURAL\nSIDE TABLE",
                        textAlign: itemTextAlignment,
                        style: new TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          height: 1.3,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomSheet() {
    return new Container(
      height: MediaQuery.of(context).size.height * 0.4,
      color: Colors.white,
      child: new Material(
        child: new Stack(
          children: [
            new Positioned(
              top: 10.0,
              right: 10.0,
              child: new IconButton(
                icon: new Icon(Icons.close, color: Colors.black),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                new Padding(
                  padding: const EdgeInsets.only(
                      left: 20.0, right: 20.0, bottom: 5.0),
                  child: new Text(
                    "Toggle between an iOS and Android design screen to view the unified user experence.",
                    textAlign: _platformTextAlignment,
                    style: new TextStyle(
                      letterSpacing: 0.6,
                      fontSize: 16.0,
                      height: 1.4,
                    ),
                  ),
                ),
                _buildRadioButtons(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroWidget() {
    Offset offset = new Offset(1.5, 0.0);
    Animation<Offset> animation = _initSlideAnimation(
      from: offset,
      to: const Offset(0.0, 0.0),
      curve: Curves.easeOut,
      controller: _animationController,
    );
    Image heroImage = new Image(
      fit: BoxFit.cover,
      image: new AssetImage(_heroImageString),
    );
    return new Expanded(
      child: new GestureDetector(
        onTap: (() {
          _tappedHero();
        }),
        child: new SlideTransition(
          position: animation,
          child: new Hero(
            tag: "platform.hero",
            child: new Material(
              child: new Container(
                child: new Stack(
                  children: [
                    new Positioned.fill(
                        child: new OverflowBox(
                      maxWidth: MediaQuery.of(context).size.width,
                      child: heroImage,
                    )),
                    new Positioned.fill(
                      child: new Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          new Text(
                            "FEATURED",
                            style: new TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                          new Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: new Text(
                              "GEOMETRIC DINING CHAIR",
                              style: new TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.6,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _buildRadioButtons() {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        new Column(
          children: [
            new Radio<int>(
                value: 0,
                groupValue: _radioValue,
                onChanged: _handleRadioValueChanged),
            new Text(
              "iOS",
              style: new TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
                color: const Color(0xFFAAAAAA),
              ),
            ),
          ],
        ),
        new Column(
          children: [
            new Radio<int>(
                value: 1,
                groupValue: _radioValue,
                onChanged: _handleRadioValueChanged),
            new Text(
              "ANDROID",
              style: new TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
                color: const Color(0xFFAAAAAA),
              ),
            ),
          ],
        ),
      ],
    );
  }

  _configureAnimation() {
    _animationController = new AnimationController(
      duration: const Duration(milliseconds: _kAnimationInDuration),
      vsync: this,
    );
    _fadeInAnimation = _initAnimation(
        from: 0.0,
        to: 1.0,
        curve: Curves.easeOut,
        controller: _animationController);
    _leftPaneAnimationController = new AnimationController(
      duration: new Duration(milliseconds: _kAnimationInDuration + 100),
      vsync: this,
    );
    _rightPaneAnimationController = new AnimationController(
      duration: new Duration(milliseconds: _kAnimationInDuration + 100),
      vsync: this,
    );
    Offset offset = new Offset(1.5, 0.0);
    _leftPaneAnimation = _initSlideAnimation(
      from: offset,
      to: const Offset(0.0, 0.0),
      curve: Curves.easeOut,
      controller: _leftPaneAnimationController,
    );
    _rightPaneAnimation = _initSlideAnimation(
      from: offset,
      to: const Offset(0.0, 0.0),
      curve: Curves.easeOut,
      controller: _rightPaneAnimationController,
    );
  }

  _configureThemes() {
    if (_targetPlatform == null) {
      _targetPlatform = Theme.of(context).platform;
      _radioValue = _targetPlatform == TargetPlatform.android ? 1 : 0;
    }
    if (_radioValue == null) {
      _radioValue = _targetPlatform == TargetPlatform.android ? 1 : 0;
    }
    _platformTextAlignment = _targetPlatform == TargetPlatform.android
        ? TextAlign.left
        : TextAlign.center;
    TextTheme textTheme = Theme.of(context).textTheme;
    TextStyle iOSButtonTextStyle = textTheme.button.copyWith(
        fontSize: 14.0, color: Colors.white, fontWeight: FontWeight.bold);
    TextStyle androidButtonTextStyle = textTheme.button.copyWith(
        fontSize: 16.0, color: Colors.white, fontWeight: FontWeight.normal);
    TextStyle targetPlatformButtonTextStyle =
        _targetPlatform == TargetPlatform.iOS
            ? iOSButtonTextStyle
            : androidButtonTextStyle;
    _themeData = new ThemeData(
      primaryColor: Colors.white,
      buttonColor: const Color(0xFF3D3D3D),
      iconTheme: const IconThemeData(color: const Color(0xFF4A4A4A)),
      brightness: Brightness.light,
      platform: _targetPlatform,
    );
  }

  Widget _contentWidget() {
    return new Scaffold(
//      bottomNavigationBar: new BottomNavigationBar(
//        items: _buildBottomNavBar(),
//      ),
      body: new Column(
        children: [
          _buildAppBar(),
          _buildBody(),
//        _buildBottomButton(),
        ],
      ),
    );
  }

  _handleRadioValueChanged(int value) {
    setState(() {
      Navigator.of(context).pop();
      _radioValue = value;
      _targetPlatform =
          _radioValue == 0 ? TargetPlatform.iOS : TargetPlatform.android;
    });
  }

  Animation<double> _initAnimation(
      {@required double from,
      @required double to,
      @required Curve curve,
      @required AnimationController controller}) {
    final CurvedAnimation animation = new CurvedAnimation(
      parent: controller,
      curve: curve,
    );
    return new Tween<double>(begin: from, end: to).animate(animation);
  }

  Animation<Offset> _initSlideAnimation(
      {@required Offset from,
      @required Offset to,
      @required Curve curve,
      @required AnimationController controller}) {
    final CurvedAnimation animation = new CurvedAnimation(
      parent: controller,
      curve: curve,
    );
    return new Tween<Offset>(begin: from, end: to).animate(animation);
  }

  _tappedHero() {
    Navigator.push(
      context,
      new MaterialPageRoute<Null>(
        settings: new RouteSettings(),
        builder: (BuildContext context) {
          return new PlatformDetailDemo(targetPlatform: _targetPlatform);
        },
      ),
    );
  }

  showDemoDialog<T>({BuildContext context, Widget child}) {
    showDialog<T>(
      context: context,
      child: child,
      barrierDismissible: false,
    )
        .then<Null>((T value) {});
  }
}
