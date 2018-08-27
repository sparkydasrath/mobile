// ignore: invalid_constant
// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/src/cupertino/button.dart';
import 'package:meta/meta.dart';
import 'package:posse_gallery/config/constants.dart';
import 'package:posse_gallery/screens/demos/assets_demo_detail.dart';

class AssetsDemo extends StatefulWidget {
  @override
  AssetsDemoState createState() => new AssetsDemoState();
}

class AssetsDemoState extends State<AssetsDemo> with TickerProviderStateMixin {
  static const int _kHeroAnimationDuration = 500;
  static const int _kFadeInAnimationDuration = 400;
  ThemeData selectedTheme;
  ThemeData luxuryThemeData;
  ThemeData playfulThemeData;
  ThemeData darkTheme;

  TargetPlatform targetPlatform;

  Animation<double> _rotationAnimation;
  Animation<double> _bodyRotationAnimation;
  Animation<Offset> _slideInAnimation;
  Animation<double> _fadeInAnimation;

  AnimationController _heroAnimationController;
  AnimationController _fadeInAnimationController;

  String appBarTitle = "My Recipe Book";
  String bottomButtonTitle = "View Recipe";

  bool showMoreButton = false;
  bool showNextButton = false;

  TabController tabController;

  final List<Tab> _tabs = [
    new Tab(
      text: "LUXURY",
      icon: new ImageIcon(
        new AssetImage("assets/icons/ic_assets_diamond.png"),
      ),
    ),
    new Tab(
      text: "PLAYFUL",
      icon: new ImageIcon(
        new AssetImage("assets/icons/ic_assets_smiley.png"),
      ),
    ),
    new Tab(
      text: "DARK",
      icon: new ImageIcon(
        new AssetImage("assets/icons/ic_assets_moon.png"),
      ),
    ),
  ];

  AssetsDemoState() {
    _configureAnimation();
  }

  @override
  Widget build(BuildContext context) {
    _configureThemes();
    if (tabController.index == 0) {
      selectedTheme = luxuryThemeData;
    } else if (tabController.index == 1) {
      selectedTheme = playfulThemeData;
    } else if (tabController.index == 2) {
      selectedTheme = darkTheme;
    } else {
      selectedTheme = luxuryThemeData;
    }
    return new Theme(
      data: selectedTheme,
      child: new Material(
        color: selectedTheme.primaryColor,
        child: _contentWidget(),
      ),
    );
  }

  Widget buildAppBar() {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    TargetPlatform targetPlatform = Theme.of(context).platform;
    TextAlign titleTextAlignment = targetPlatform == TargetPlatform.iOS
        ? TextAlign.center
        : TextAlign.left;
    bool isAndroid = targetPlatform == TargetPlatform.android;
    final IconData backIcon =
        isAndroid ? Icons.arrow_back : Icons.arrow_back_ios;

    final topWidgets = <Widget>[
      new Positioned(
        top: 0.0,
        bottom: 0.0,
        left: 5.0,
        child: new IconButton(
          icon: new Icon(
            backIcon,
            color: selectedTheme.iconTheme.color,
          ),
          onPressed: () {
            tappedBackButton();
          },
        ),
      ),
      new Positioned.fill(
        left: 60.0,
        right: 60.0,
        child: new Center(
          child: new Text(
            appBarTitle,
            style: new TextStyle(
              color: selectedTheme.textTheme.title.color,
              fontWeight: FontWeight.w500,
              fontSize: 20.0,
            ),
            textAlign: titleTextAlignment,
          ),
        ),
      ),
    ];
    if (showMoreButton) {
      topWidgets.add(
        new Positioned(
          right: 5.0,
          top: 0.0,
          bottom: 0.0,
          child: new IconButton(
            icon: new Icon(
              Icons.more_vert,
              color: selectedTheme.iconTheme.color,
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
        ),
      );
    }
    if (isAndroid) {
      var shadowWidget = new Positioned(
          top: 0.0,
          left: 0.0,
          right: 0.0,
          child: new Container(
            height: 4.0,
            color: new Color(0x11000000),
          ));
      topWidgets.insert(0, shadowWidget);
    }

    return new Padding(
      padding: new EdgeInsets.only(top: statusBarHeight),
      child: new ConstrainedBox(
        constraints:
            new BoxConstraints.expand(height: Constants.TopSectionHeight),
        child: new Stack(
          children: topWidgets,
        ),
      ),
    );
  }

  Widget buildBody() {
    _startAnimation();
    return new Expanded(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          new Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: new SlideTransition(
              position: _slideInAnimation,
              child: new FadeTransition(
                opacity: _fadeInAnimation,
                child: new RotationTransition(
                  turns: _rotationAnimation,
                  child: new Container(
                    decoration: _buildRadialGradient(),
                    child: new Padding(
                      padding: const EdgeInsets.only(top: 25.0, bottom: 15.0),
                      child: new Image(
                        width: MediaQuery.of(context).size.width * 0.6,
                        image:
                            new AssetImage("assets/images/brand_apple_pie.png"),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          new SlideTransition(
            position: _slideInAnimation,
            child: new FadeTransition(
              opacity: _fadeInAnimation,
              child: new Column(
                children: [
                  new Text(
                    "Classic Apple Pie",
                    style: new TextStyle(
                      color: selectedTheme.textTheme.title.color,
                      fontSize: 22.0,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  new Padding(
                    padding: const EdgeInsets.only(top: 20.0, bottom: 5.0),
                    child: new Image(
                      width: MediaQuery.of(context).size.width * 0.15,
                      image: new AssetImage("assets/images/brand_profile.png"),
                    ),
                  ),
                  new Text(
                    "By Jenny Flay",
                    style: new TextStyle(
                      color: selectedTheme.textTheme.subhead.color,
                      fontSize: 14.0,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  new Container(
                    padding: const EdgeInsets.only(top: 30.0, bottom: 20.0),
                    child: new Center(
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          new Padding(
                            padding: const EdgeInsets.only(right: 15.0),
                            child: new Image(
                              height: 15.0,
                              image: new AssetImage(
                                  "assets/images/brand_stars.png"),
                            ),
                          ),
                          new Text(
                            "120",
                            style: new TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.normal,
                              color: selectedTheme.textTheme.body1.color,
                            ),
                          ),
                          new Text(
                            " Mins",
                            style: new TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.normal,
                              color: selectedTheme.textTheme.body2.color,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildBottomButton() {
    if (targetPlatform == TargetPlatform.android) {
      bottomButtonTitle = bottomButtonTitle.toUpperCase();
    }
    double buttonBorderRadius =
        targetPlatform == TargetPlatform.iOS ? 9.0 : 0.0;
    Color borderColor =
        targetPlatform == TargetPlatform.iOS && selectedTheme == luxuryThemeData
            ? const Color(0xFF5FAD2C)
            : selectedTheme.buttonColor;
    Color cupertinoTextColor = selectedTheme == luxuryThemeData
        ? const Color(0xFF5FAD2C)
        : Colors.white;
    Color cupertinoButtonColor = selectedTheme == luxuryThemeData
        ? Colors.white
        : selectedTheme.buttonColor;
    CupertinoButton cupertinoButton = new CupertinoButton(
      color: cupertinoButtonColor,
      child: new Text(
        bottomButtonTitle,
        textAlign: TextAlign.center,
        style: new TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.normal,
          color: cupertinoTextColor,
        ),
      ),
      onPressed: (() {
        tappedNextButton();
      }),
    );
    FlatButton androidButton = new FlatButton(
        color: selectedTheme.buttonColor,
        child: new Text(
          bottomButtonTitle,
          textAlign: TextAlign.center,
          style: new TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.normal,
            color: Colors.white,
          ),
        ),
        onPressed: () {
          tappedNextButton();
        });
    Widget platformButton =
        targetPlatform == TargetPlatform.iOS ? cupertinoButton : androidButton;
    return new Container(
      decoration: new BoxDecoration(
        borderRadius: new BorderRadius.circular(buttonBorderRadius),
        border: new Border.all(
          color: borderColor,
          width: 1.0,
        ),
      ),
      margin: new EdgeInsets.all(8.0),
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

  @override
  dispose() {
    _heroAnimationController.dispose();
    super.dispose();
  }

  @override
  initState() {
    super.initState();
    _configureUI();
    _registerObservables();
    setState(() {
      showMoreButton = true;
      showNextButton = true;
    });
  }

  void showDemoDialog<T>({BuildContext context, Widget child}) {
    showDialog<T>(
      context: context,
      child: child,
      barrierDismissible: false,
    )
        .then<Null>((T value) {});
  }

  tappedBackButton() {
    _heroAnimationController.reverse();
    _fadeInAnimationController.reverse().whenComplete(() {
      Navigator.of(context).pop();
    });
  }

  tappedNextButton() {
    Navigator.push(
      context,
      new MaterialPageRoute<Null>(
        settings: new RouteSettings(),
        builder: (BuildContext context) {
          return new AssetsDetailDemo(themeIndex: tabController.index);
        },
      ),
    );
  }

  Widget _buildBottomSheet() {
    return new Container(
      height: MediaQuery.of(context).size.height * 0.4,
      color: Colors.white,
      child: new Material(
        child: new Column(
          children: [
            new Align(
              alignment: FractionalOffset.centerRight,
              child: new IconButton(
                icon: new Icon(Icons.close, color: Colors.black),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            new Expanded(
              child: new Center(
                child: new Padding(
                  padding: const EdgeInsets.only(
                      left: 50.0, right: 50.0, bottom: 42.0),
                  child: new Text(
                    "Toggle between themes to see how changing elements can give an app a whole new identity.",
                    textAlign: TextAlign.center,
                    style: new TextStyle(
                      letterSpacing: 0.6,
                      fontSize: 16.0,
                      height: 1.4,
                    ),
                  ),
                ),
              ),
            ),
            _buildTabBar(),
          ],
        ),
      ),
    );
  }

  _buildRadialGradient() {
    if (tabController.index == 1) {
      return new BoxDecoration(
        gradient: new RadialGradient(
          center: FractionalOffset.center,
          radius: 0.51,
          colors: [
            Colors.white,
            const Color(0xFFF68D99),
            selectedTheme.primaryColor,
          ],
          stops: [0.0, 0.35, 1.0],
        ),
      );
    } else {
      return null;
    }
  }

  Widget _buildTabBar() {
    TabBar tabBar = new TabBar(
      controller: tabController,
      isScrollable: false,
      labelColor: Theme.of(context).primaryColor,
      unselectedLabelColor: const Color(0xFFAAAAAA),
      indicatorColor: Theme.of(context).primaryColor,
      labelStyle: new TextStyle(
        fontSize: 14.0,
      ),
      tabs: _tabs,
    );
    return new Padding(
        padding: const EdgeInsets.only(bottom: 1.0),
        child: new Center(child: tabBar));
  }

  _configureAnimation() {
    _heroAnimationController = new AnimationController(
      duration: const Duration(milliseconds: _kHeroAnimationDuration),
      vsync: this,
    );
    _fadeInAnimationController = new AnimationController(
      duration: const Duration(milliseconds: _kFadeInAnimationDuration),
      vsync: this,
    );
    _rotationAnimation = _initAnimation(
        from: 0.0,
        to: 1.0,
        curve: Curves.easeOut,
        controller: _heroAnimationController);
    _slideInAnimation = _initSlideAnimation(
        from: const Offset(-2.0, 0.0),
        to: const Offset(0.0, 0.0),
        curve: Curves.decelerate,
        controller: _heroAnimationController);
    _fadeInAnimation = _initAnimation(
        from: 0.0,
        to: 1.0,
        curve: Curves.easeInOut,
        controller: _fadeInAnimationController);
    _bodyRotationAnimation = _initAnimation(
        from: 0.8,
        to: 1.0,
        curve: Curves.easeOut,
        controller: _fadeInAnimationController);
  }

  _configureThemes() {
    targetPlatform = Theme.of(context).platform;
    TextTheme luxuryTextTheme = Theme.of(context).textTheme;
    TextStyle luxuryTitleTextStyle =
        luxuryTextTheme.title.copyWith(color: const Color(0xFF4A4A4A));
    TextStyle luxurySubheadTextStyle =
        luxuryTextTheme.subhead.copyWith(color: const Color(0xFFAAAAAA));
    TextStyle luxuryBody1TextStyle =
        luxuryTextTheme.body1.copyWith(color: const Color(0xFF4A4A4A));
    TextStyle luxuryBody2TextStyle =
        luxuryTextTheme.body2.copyWith(color: const Color(0xFF979797));
    TextStyle luxuryButtonTextStyle =
        luxuryTextTheme.button.copyWith(color: Colors.white);
    luxuryThemeData = new ThemeData(
      primaryColor: Colors.white,
      buttonColor: targetPlatform == TargetPlatform.iOS
          ? Colors.white
          : const Color(0xFF5FAD2C),
      iconTheme: const IconThemeData(color: const Color(0xFFD1D1D1)),
      textTheme: new TextTheme(
        title: luxuryTitleTextStyle,
        subhead: luxurySubheadTextStyle,
        body1: luxuryBody1TextStyle,
        body2: luxuryBody2TextStyle,
        button: luxuryButtonTextStyle,
      ),
      brightness: Brightness.dark,
      platform: targetPlatform,
    );
    playfulThemeData = new ThemeData(
      primaryColor: const Color(0xFFF0465A),
      buttonColor: const Color(0xFF1DBC98),
      iconTheme: const IconThemeData(color: Colors.white),
      textTheme: new Typography(platform: targetPlatform).white,
      brightness: Brightness.light,
      platform: targetPlatform,
    );
    darkTheme = new ThemeData(
      primaryColor: const Color(0xFF212121),
      buttonColor: const Color(0xFF4A4A4A),
      iconTheme: const IconThemeData(color: Colors.white),
      textTheme: new Typography(platform: targetPlatform).white,
      brightness: Brightness.dark,
      platform: targetPlatform,
    );
    if (selectedTheme == playfulThemeData) {
      bottomButtonTitle = "Let's get cooking!";
    } else {
      bottomButtonTitle = "View Recipe";
    }
  }

  _configureUI() {
    tabController = new TabController(
      vsync: this,
      length: _tabs.length,
    );
  }

  Widget _contentWidget() {
    List<Widget> widgets = [];
    widgets.add(buildAppBar());
    widgets.add(buildBody());
    if (showNextButton) {
      widgets.add(buildBottomButton());
    }
    return new Column(
      children: widgets,
    );
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

  _registerObservables() {
    tabController.addListener(() {
      setState(() {});
    });
  }

  _startAnimation() {
    _heroAnimationController.forward();
    _fadeInAnimationController.forward();
  }
}
