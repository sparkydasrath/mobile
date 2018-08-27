// ignore: const_with_non_constant_argument
// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

class PlatformDetailDemo extends StatefulWidget {
  final TargetPlatform _targetPlatform;

  PlatformDetailDemo({
    TargetPlatform targetPlatform,
  })
      : _targetPlatform = targetPlatform;

  @override
  _PlatformDetailDemoState createState() =>
      new _PlatformDetailDemoState(targetPlatform: _targetPlatform);
}

class _PlatformDetailDemoState extends State<PlatformDetailDemo>
    with TickerProviderStateMixin {
  static final GlobalKey<ScaffoldState> _scaffoldKey =
      new GlobalKey<ScaffoldState>();
  static const int _kAnimationInDuration = 300;
  static const int _kSlideInAnimationDuration = 250;
  static const int _kHeartAnimationDuration = 300;
  TargetPlatform _targetPlatform;

  ThemeData _themeData;

  Animation<double> _scaleInAnimation;
  Animation<Offset> _slideInAnimation;
  Animation<double> _heartAnimation;

  AnimationController _animationController;
  AnimationController _slideInAnimationController;
  AnimationController _heartAnimationController;

  Color _heartColor = Colors.white;

  int _heartCount = 1324;

  String _appBarTitle = "";

  _PlatformDetailDemoState({
    TargetPlatform targetPlatform,
  })
      : _targetPlatform = targetPlatform;

  @override
  Widget build(BuildContext context) {
    _configureThemes();
    return new Theme(
      data: _themeData,
      child: new Material(
        color: Colors.white,
        child: _contentWidget(),
      ),
    );
  }

  @override
  dispose() {
    _animationController.dispose();
    _slideInAnimationController.dispose();
    _heartAnimationController.dispose();
    super.dispose();
  }

  @override
  initState() {
    super.initState();
    _configureAnimation();
    _animationController.forward();
    _slideInAnimationController.forward();
  }

  showDemoDialog<T>({BuildContext context, Widget child}) {
    showDialog<T>(
      context: context,
      child: child,
      barrierDismissible: false,
    )
        .then<Null>((T value) {});
  }

  Widget _buildBottomButton() {
    double buttonBorderRadius =
        _targetPlatform == TargetPlatform.iOS ? 8.0 : 0.0;
    double margin = _targetPlatform == TargetPlatform.iOS ? 8.0 : 0.0;
    Color buttonColor = _targetPlatform == TargetPlatform.iOS
        ? Colors.white
        : const Color(0xFF3D3D3D);
    Color textColor = _targetPlatform == TargetPlatform.iOS
        ? const Color(0xFF3D3D3D)
        : Colors.white;
    TextStyle iOSCartTextStyle = new TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.normal,
      color: textColor,
    );
    TextStyle androidCartTextStyle = new TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.bold,
      color: textColor,
    );
    Text addToCartText = new Text(
      "ADD TO CART",
      style: _targetPlatform == TargetPlatform.iOS
          ? iOSCartTextStyle
          : androidCartTextStyle,
    );
    CupertinoButton cupertinoButton = new CupertinoButton(
      color: _themeData.buttonColor,
      child: addToCartText,
      onPressed: (() {
        showDemoDialog(
          context: context,
          child: new CupertinoAlertDialog(
              title: const Text('Modern Furniture'),
              content: const Text('Added to cart!'),
              actions: <Widget>[
                new CupertinoDialogAction(
                    child: const Text('Keep Shopping',
                        style: const TextStyle(fontWeight: FontWeight.w600)),
                    onPressed: () {
                      Navigator.pop(context, 'Keep Shopping');
                    }),
              ]),
        );
      }),
    );
    FlatButton androidButton = new FlatButton(
      color: _themeData.buttonColor,
      child: addToCartText,
      onPressed: () {
        _scaffoldKey.currentState.showSnackBar(
          const SnackBar(content: const Text('Added to cart!')),
        );
      },
    );
    Widget platformButton =
        _targetPlatform == TargetPlatform.iOS ? cupertinoButton : androidButton;
    return new Container(
      decoration: new BoxDecoration(
        borderRadius: new BorderRadius.circular(buttonBorderRadius),
        border: new Border.all(
          color: const Color(0xFF3D3D3D),
          width: 1.0,
        ),
        color: buttonColor,
      ),
      margin: new EdgeInsets.all(margin),
      child: new Row(
        children: [
          new Expanded(
            child: new Container(
              height: 50.0,
              child: platformButton,
            ),
          ),
        ],
      ),
    );
  }

  _buildDetailsTable() {
    Table detailTable = new Table(
      children: [
        _detailsTableRow("Tested For", "243 lb"),
        _detailsTableRow("Width", "16 7/8 \""),
        _detailsTableRow("Depth", "20 1/2 \""),
        _detailsTableRow("Height", "35 7/8 \""),
        _detailsTableRow("Seat Width", "16 1/8 \""),
        _detailsTableRow("Seat Depth", "15 \""),
        _detailsTableRow("Seat Height", "17 3/8 \"", showBottomBorder: false),
      ],
    );
    return detailTable;
  }

  Widget _buildHeroContent() {
    NumberFormat heart = new NumberFormat("#,###", "en_US");
    return new Container(
      child: new Stack(
        children: [
          new Positioned.fill(
            child: new Container(
              color: const Color(0x40333333),
            ),
          ),
          new Positioned(
            top: 75.0,
            right: 50.0,
            child: new Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                new Text(
                  "THE GEO COLLECTION",
                  style: new TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                new Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: new Text(
                    "GEOMETRIC DINING CHAIR",
                    style: new TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          new Positioned(
            left: 30.0,
            bottom: 30.0,
            child: new ScaleTransition(
              scale: _scaleInAnimation,
              child: new Row(
                children: [
                  new ScaleTransition(
                    scale: _heartAnimation,
                    child: new IconButton(
                      icon: new Icon(Icons.favorite, color: _heartColor),
                      color: _heartColor,
                      onPressed: (() {
                        setState(() {
                          _heartColor = _heartColor == Colors.red
                              ? Colors.white
                              : Colors.red;
                          _heartCount += _heartColor == Colors.red ? 1 : -1;
                          _heartAnimationController.forward().whenComplete(() {
                            _heartAnimationController.reverse();
                          });
                        });
                      }),
                    ),
                  ),
                  new Text(
                    heart.format(_heartCount).toString(),
                    style: new TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          new Positioned(
            right: 30.0,
            bottom: 35.0,
            child: new ScaleTransition(
              scale: _scaleInAnimation,
              child: new Container(
                decoration: new BoxDecoration(
                  color: _targetPlatform == TargetPlatform.iOS
                      ? Colors.white
                      : const Color(0xFFF5A623),
                  border: new Border.all(
                    color: const Color(0xFFF5A623),
                    width: 1.0,
                  ),
                ),
                padding: const EdgeInsets.all(10.0),
                child: new Text(
                  "\$321",
                  style: new TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                    color: _targetPlatform == TargetPlatform.iOS
                        ? const Color(0xFFF5A623)
                        : Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildListContent() {
    List<Widget> cells = [];
    final textContainer = new Padding(
      padding: const EdgeInsets.only(top: 30.0, left: 45.0, right: 45.0),
      child: new SlideTransition(
        position: _slideInAnimation,
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            new Padding(
              padding: const EdgeInsets.only(bottom: 30.0),
              child: new Text(
                "About The Geometric\nDining Chair",
                textAlign: TextAlign.left,
                style: new TextStyle(
                  color: const Color(0xFF4A4A4A),
                  fontWeight: FontWeight.w900,
                  fontSize: 16.0,
                  height: 1.5,
                ),
              ),
            ),
            new Padding(
              padding: const EdgeInsets.only(bottom: 30.0),
              child: new Text(
                "A chair is a piece of furniture with a raised surface supported by legs, commonly used to seat a single person. Chairs are supported most often by four legs and have a back; however, a chair can have three legs or can have a different shape.",
                style: new TextStyle(
                  color: const Color(0xFF4A4A4A),
                  fontWeight: FontWeight.w400,
                  fontSize: 16.0,
                  height: 1.5,
                ),
              ),
            ),
            new Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: new Text(
                "Product Dimensions",
                style: new TextStyle(
                  color: const Color(0xFF4A4A4A),
                  fontWeight: FontWeight.w600,
                  fontSize: 16.0,
                  height: 1.5,
                ),
              ),
            ),
            new Padding(
              padding: const EdgeInsets.only(bottom: 30.0),
              child: _buildDetailsTable(),
            ),
            new Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: new Text(
                "Care Instructions",
                style: new TextStyle(
                  color: const Color(0xFF4A4A4A),
                  fontWeight: FontWeight.w600,
                  fontSize: 16.0,
                  height: 1.5,
                ),
              ),
            ),
            new Padding(
              padding: const EdgeInsets.only(bottom: 30.0),
              child: new Text(
                "- Wipe clean using a damp cloth and a mild cleaner.\n"
                    "- Wipe dry with a clean cloth.\n",
                style: new TextStyle(
                  color: const Color(0xFF4A4A4A),
                  fontWeight: FontWeight.w400,
                  fontSize: 16.0,
                  height: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
    cells.add(textContainer);
    return cells;
  }

  _configureAnimation() {
    _animationController = new AnimationController(
      duration: const Duration(milliseconds: _kAnimationInDuration),
      vsync: this,
    );
    _slideInAnimationController = new AnimationController(
      duration: const Duration(milliseconds: _kSlideInAnimationDuration),
      vsync: this,
    );
    _heartAnimationController = new AnimationController(
      duration: const Duration(milliseconds: _kHeartAnimationDuration),
      vsync: this,
    );
    _scaleInAnimation = _initAnimation(
        from: 0.01,
        to: 1.0,
        curve: Curves.easeOut,
        controller: _animationController);
    _slideInAnimation = _initSlideAnimation(
        from: const Offset(0.0, 0.0),
        to: const Offset(0.0, 0.0),
        curve: Curves.easeIn,
        controller: _slideInAnimationController);
    _heartAnimation = _initAnimation(
        from: 1.0,
        to: 1.5,
        curve: Curves.easeOut,
        controller: _heartAnimationController);
  }

  _configureThemes() {
    TextTheme textTheme = Theme.of(context).textTheme;
    TextStyle iOSButtonTextStyle = textTheme.button.copyWith(
        fontSize: 14.0, color: Colors.white, fontWeight: FontWeight.bold);
    TextStyle androidButtonTextStyle = textTheme.button.copyWith(
        fontSize: 16.0, color: Colors.white, fontWeight: FontWeight.normal);
    TextStyle targetPlatformButtonTextStyle =
        _targetPlatform == TargetPlatform.iOS
            ? iOSButtonTextStyle
            : androidButtonTextStyle;
    Color buttonColor = _targetPlatform == TargetPlatform.iOS
        ? Colors.white
        : const Color(0xFF3D3D3D);
    Color splashColor = _targetPlatform == TargetPlatform.iOS
        ? const Color(0xFF3D3D3D)
        : Colors.white;
    _themeData = new ThemeData(
      primaryColor: Colors.white,
      buttonColor: buttonColor,
      splashColor: splashColor,
      iconTheme: const IconThemeData(color: const Color(0xFF4A4A4A)),
      brightness: Brightness.light,
      platform: _targetPlatform,
    );
  }

  Widget _contentWidget() {
    return new Scaffold(
      key: _scaffoldKey,
      body: new NotificationListener<ScrollNotification>(
        onNotification: _handleScrollNotification,
        child: new CustomScrollView(
          slivers: [
            new SliverAppBar(
              backgroundColor: const Color(0xFF3D3D3D),
              pinned: true,
              title: new Text(
                _appBarTitle,
                style: new TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 20.0,
                ),
              ),
              leading: new Material(
                color: const Color(0x00FFFFFF),
                child: new ScaleTransition(
                  scale: _scaleInAnimation,
                  child: new CloseButton(),
                ),
              ),
              expandedHeight: MediaQuery.of(context).size.height * 0.5,
              flexibleSpace: new FlexibleSpaceBar(
                background: new Hero(
                  tag: "platform.hero",
                  child: new Material(
                    child: new Stack(
                      children: [
                        new Positioned.fill(
                          child: new OverflowBox(
                            maxWidth: MediaQuery.of(context).size.width,
                            child: new Image(
                              fit: BoxFit.cover,
                              image: new AssetImage(
                                  "assets/images/platform_hero.png"),
                            ),
                          ),
                        ),
                        _buildHeroContent(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            new SliverList(
              delegate: new SliverChildListDelegate(_buildListContent()),
            ),
          ],
        ),
      ),
      bottomNavigationBar: new Material(
        elevation: 10.0,
        child: _buildBottomButton(),
      ),
    );
  }

  _detailsTableRow(String itemString, String valueString,
      {bool showBottomBorder = true}) {
    return new TableRow(
      children: [
        new Padding(
          padding: new EdgeInsets.only(top: 12.0, bottom: 12.0),
          child: new Text(itemString,
              style: new TextStyle(
                color: new Color(0xFF777777),
              )),
        ),
        new Padding(
          padding: new EdgeInsets.only(left: 8.0, top: 12.0, bottom: 12.0),
          child: new Text(valueString),
        ),
      ],
      decoration: (showBottomBorder
          ? new BoxDecoration(
              border: new Border(
                  bottom: new BorderSide(color: new Color(0xFFF1F1F1))),
            )
          : null),
    );
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    String title = "Geometric Dining Chair";
    double visibleStatsHeight = notification.metrics.pixels;
    double screenHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    double visiblePercentage = visibleStatsHeight / screenHeight;
    if (visiblePercentage > 0.45 && _appBarTitle != title) {
      setState(() {
        _appBarTitle = title;
      });
    } else if (visiblePercentage < 0.45 && _appBarTitle.isNotEmpty) {
      setState(() {
        _appBarTitle = "";
      });
    }
    return false;
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
}
