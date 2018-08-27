// ignore: invalid_constant
// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/services/system_chrome.dart';
import 'package:meta/meta.dart';
import 'package:posse_gallery/config/application.dart';
import 'package:posse_gallery/managers/category_manager.dart';
import 'package:posse_gallery/models/app_category.dart';
import 'package:posse_gallery/views/cells/main_link_cell.dart';
import 'package:url_launcher/url_launcher.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => new _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  static const int _kAnimationDuration = 250;

  List<Widget> _cells;

  Animation<double> _fadeInAnimation;
  AnimationController _animationController;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return new Material(
      color: new Color(0xFFEEEEEE),
      child: new Center(
        child: new FadeTransition(
          opacity: _fadeInAnimation,
          child: _contentWidget(),
        ),
      ),
    );
  }

  @override
  dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _configureAnimation();
    _animationController.forward();
    setState(() {
      _cells = <Widget>[];
      _cells.add(_buildTopSection());
      _cells.addAll(_loadCategories());
      _cells.add(new ConstrainedBox(constraints: new BoxConstraints.expand(height: 30.0)));
      _cells.add(new MainLinkCell(
        "Debug Stuff",
        "Toggle settings and options.",
        "assets/icons/ic_feed_settings.png",
        tapped: () {
          _tappedDebugItem();
        },
      ));
      _cells.add(new MainLinkCell(
        "Flutter",
        "Visit the Flutter web site for more information on Flutter and how to get started.",
        "assets/icons/ic_feed_flutter.png",
        tapped: () {
          openURL("https://flutter.io");
        },
      ));
      _cells.add(new MainLinkCell(
        "Flutter Docs",
        "Browse the Flutter API docs from the comfort of your phone.",
        "assets/icons/ic_feed_docs.png",
        tapped: () {
          openURL("https://docs.flutter.io");
        },
      ));
      _cells.add(new MainLinkCell(
        "Posse",
        "Check out Posse's website.",
        "assets/icons/ic_feed_posse.png",
        tapped: () {
          openURL("http://goposse.com");
        },
      ));
      _cells.add(new ConstrainedBox(constraints: new BoxConstraints.expand(height: 40.0)));
    });
  }

  openURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  Widget _buildTopSection() {
    return new ConstrainedBox(
      constraints: new BoxConstraints.expand(height: 200.0),
      child: new Padding(
        padding: new EdgeInsets.only(top: 25.0, right: 20.0),
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const FlutterLogo(size: 44.0),
            new Padding(
              padding: new EdgeInsets.only(left: 10.0),
              child: new Text(
                "Flutter Gallery",
                textAlign: TextAlign.center,
                style: new TextStyle(
                  fontWeight: FontWeight.w400,
                  letterSpacing: 1.5,
                  height: 1.3,
                  fontSize: 26.0,
                  color: const Color(0xFF666666),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListView() {
    return new ListView(
      children: _cells,
    );
  }

  Widget _categoryTextWidget({category: AppCategory, categoryIndex: int}) {
    String formattedIndex = categoryIndex.toString().padLeft(2, '0');
    return new Center(
      child: new Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          new Text(
            formattedIndex,
            textAlign: TextAlign.center,
            style: new TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 10.0,
              color: Colors.white,
            ),
          ),
          new Padding(
            padding: const EdgeInsets.only(left: 30.0, right: 30.0, top: 7.0),
            child: new Text(
              category.title.toUpperCase(),
              textAlign: TextAlign.center,
              style: new TextStyle(
                fontWeight: FontWeight.w700,
                letterSpacing: 1.6,
                height: 1.3,
                fontSize: 20.0,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  _configureAnimation() {
    _animationController = new AnimationController(
      duration: const Duration(milliseconds: _kAnimationDuration),
      vsync: this,
    );
    _fadeInAnimation = _initAnimation(
        from: 0.0,
        to: 1.0,
        curve: Curves.easeOut,
        controller: _animationController);
  }

  Widget _contentWidget() {
    return new Stack(
      children: [
        new Positioned(
          top: 0.0,
          right: 0.0,
          child: new Image(
            image: new AssetImage("assets/backgrounds/bg_main_screen.png"),
          ),
        ),
        new Positioned.fill(
          child: _buildListView(),
        ),
      ],
    );
  }

  Widget _createCell({@required AppCategory category,
    @required int categoryIndex,
    @required String routeName}) {
    return new Hero(
      tag: category.title,
      child: new Container(
        padding:
        const EdgeInsets.only(left: 8.0, right: 8.0, top: 2.0, bottom: 2.0),
        height: 156.0,
        child: new Card(
          elevation: 1.0,
          child: new Stack(
            children: [
              new Positioned.fill(
                child: new Container(color: category.centerShapeColor),
              ),
              new Positioned(
                right: 0.0,
                top: -45.0,
                child: new Image(
                  height: 200.0,
                  width: 300.0,
                  color: category.rightShapeColor,
                  image: new AssetImage(
                      "assets/images/category_cell_right_shape.png"),
                  fit: BoxFit.cover,
                ),
              ),
              new Positioned(
                left: 0.0,
                top: -40.0,
                child: new Image(
                  height: 250.0,
                  width: 210.0,
                  color: category.leftShapeColor,
                  image: new AssetImage(
                      "assets/images/category_cell_left_shape.png"),
                  fit: BoxFit.cover,
                ),
              ),
              new Positioned.fill(child: new Container(color: new Color(0x11000000))),
              _categoryTextWidget(
                  category: category, categoryIndex: categoryIndex),
              new Material(
                color: const Color(0x00FFFFFF),
                child: new InkWell(
                  highlightColor: Colors.white.withAlpha(30),
                  splashColor: Colors.white.withAlpha(20),
                  onTap: () {
                    _tappedCategoryCell(routeName);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Animation<double> _initAnimation({@required double from,
    @required double to,
    @required Curve curve,
    @required AnimationController controller}) {
    final CurvedAnimation animation = new CurvedAnimation(
      parent: controller,
      curve: curve,
    );
    return new Tween<double>(begin: from, end: to).animate(animation);
  }

  Animation<Offset> _initSlideAnimation({@required Offset from,
    @required Offset to,
    @required Curve curve,
    @required AnimationController controller}) {
    controller.duration = new Duration(milliseconds: 750);
    final CurvedAnimation animation = new CurvedAnimation(
      parent: controller,
      curve: curve,
    );
    return new Tween<Offset>(begin: from, end: to).animate(animation);
  }

  List<Widget> _loadCategories() {
    List<Widget> categoryCells = [];
    int categoryIndex = 1;
    List<AppCategory> categories = new CategoryManager().categories();
    for (AppCategory category in categories) {
      String routeName = category.routeName;
      AnimationController animationController = new AnimationController(
        duration:
        new Duration(milliseconds: _kAnimationDuration * categoryIndex),
        vsync: this,
      );
      Animation<Offset> animation = _initSlideAnimation(
        from: new Offset(1.5, 0.0),
        to: const Offset(0.0, 0.0),
        curve: new Interval(0.35 + ((categoryIndex - 1) * 0.15), 1.0, curve: Curves.easeOut),
        controller: animationController,
      );
      final categoryContainer = new SlideTransition(
        position: animation,
        child: _createCell(
            category: category,
            categoryIndex: categoryIndex,
            routeName: routeName),
      );
      animationController.forward();
      categoryCells.add(categoryContainer);
      categoryIndex += 1;
    }
    return categoryCells;
  }

  // actions
  void _tappedCategoryCell(String routeKey) {
    Application.router.navigateTo(context, "/category/$routeKey", transition: TransitionType.nativeModal);
  }

  void _tappedDebugItem() {
    var transition = (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
//      return new FadeTransition(
//        opacity: animation,
//        child: new SlideTransition(
//          position: new OffsetTween(
//            begin: new Offset(0.0, 0.35),
//            end: new Offset(0.0, 0.0),
//          ).animate(animation),
//          child: child,
//        ),
//      );
      Animation curvedAnimation = new CurvedAnimation(
        parent: animation,
        curve: new Interval(0.18, 1.0, curve: Curves.easeIn),
      );
      return new SlideTransition(
          position: new Tween<Offset>(
            begin: new Offset(0.0, 0.38),
            end: new Offset(0.0, 0.0),
          ).animate(animation),
          child: new FadeTransition(opacity: curvedAnimation, child: child),
      );
    };
    Application.router.navigateTo(context, "/debug", transition: TransitionType.custom,
        transitionDuration: new Duration(milliseconds: 170), transitionBuilder: transition);
  }
}
