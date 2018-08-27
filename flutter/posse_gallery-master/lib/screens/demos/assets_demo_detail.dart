// ignore: invalid_constant
// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:posse_gallery/screens/demos/assets_demo.dart';

class AssetsDetailDemo extends AssetsDemo {
  final int _themeIndex;

  AssetsDetailDemo({
    int themeIndex,
  })
      : _themeIndex = themeIndex;

  @override
  _AssetsDetailDemoState createState() =>
      new _AssetsDetailDemoState(themeIndex: _themeIndex);
}

class _AssetsDetailDemoState extends AssetsDemoState {
  static const int _kSlideInDuration = 500;
  static const int _kFadeOutDuration = 675;
  static const int _kFadeInDuration = 500;
  static const int _kSizeInDuration = 400;

  static final GlobalKey<ScaffoldState> _scaffoldKey =
      new GlobalKey<ScaffoldState>();

  int _themeIndex = 0;
  Animation<Offset> _slideInLeftAnimation;
  Animation<Offset> _slideInRightAnimation;
  Animation<Offset> _slideInDownAnimation;
  Animation<Offset> _slideInUpAnimation;
  Animation<double> _fadeInAnimation;
  Animation<double> _fadeOutAnimation;

  Animation<double> _sizeInAnimation;
  AnimationController _slideInAnimationController;
  AnimationController _fadeInAnimationController;
  AnimationController _fadeOutAnimationController;

  AnimationController _sizeInAnimationController;

  _AssetsDetailDemoState({
    int themeIndex,
  })
      : _themeIndex = themeIndex;

  @override
  Widget buildBody() {
    double imageHeight = MediaQuery.of(context).size.width * 0.25;
    _startAnimation();
    return new Expanded(
      child: new Column(
        children: [
          new Padding(
            padding: const EdgeInsets.only(top: 15.0, bottom: 30.0),
            child: new FadeTransition(
                opacity: _fadeOutAnimation,
                child: new Column(
                  children: [
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        new SlideTransition(
                          position: _slideInRightAnimation,
                          child: new Padding(
                            padding:
                                const EdgeInsets.only(top: 14.0, right: 10.0),
                            child: new Image(
                              height: imageHeight,
                              image:
                                  new AssetImage("assets/images/brand_egg.png"),
                            ),
                          ),
                        ),
                        new SlideTransition(
                          position: _slideInDownAnimation,
                          child: new Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: new Image(
                              height: MediaQuery.of(context).size.width * 0.35,
                              image: new AssetImage(
                                  "assets/images/brand_flour.png"),
                            ),
                          ),
                        ),
                      ],
                    ),
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        new SlideTransition(
                          position: _slideInUpAnimation,
                          child: new Padding(
                            padding: const EdgeInsets.only(top: 12.0),
                            child: new Image(
                              height: imageHeight,
                              image: new AssetImage(
                                  "assets/images/brand_cinnamon.png"),
                            ),
                          ),
                        ),
                        new SlideTransition(
                          position: _slideInLeftAnimation,
                          child: new Image(
                            height: imageHeight,
                            image:
                                new AssetImage("assets/images/brand_salt.png"),
                          ),
                        ),
                      ],
                    ),
                  ],
                )),
          ),
          new FadeTransition(
            opacity: _fadeInAnimation,
            child: new Padding(
              padding: const EdgeInsets.only(bottom: 25.0),
              child: new Text(
                "INGREDIENTS",
                style: new TextStyle(
                  color: selectedTheme.textTheme.title.color,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 2.0,
                ),
              ),
            ),
          ),
          new FadeTransition(
            opacity: _sizeInAnimation,
            child: new SizeTransition(
              sizeFactor: _sizeInAnimation,
              child: new Center(
                child: new Text(
                  "6 cups sliced, peeled apples\n"
                      "2 cups all-purpose flour\n"
                      "3/4 teaspoon salt\n"
                      "1 cup vegetable shortening\n"
                      "2 tablespoons of cold water\n"
                      "1 tablespoon of cinnamon\n"
                      "1 tablespoon lemon juice",
                  textAlign: TextAlign.center,
                  style: new TextStyle(
                    color: selectedTheme.textTheme.body1.color,
                    fontSize: 14.0,
                    fontWeight: FontWeight.normal,
                    height: 1.75,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  dispose() {
    _slideInAnimationController.dispose();
    _fadeInAnimationController.dispose();
    _fadeOutAnimationController.dispose();
    _sizeInAnimationController.dispose();
    super.dispose();
  }

  @override
  initState() {
    super.initState();
    _configureAnimation();
    setState(() {
      showNextButton = false;
      showMoreButton = false;
      tabController.index = _themeIndex;
      appBarTitle = "Classic Apple Pie";
      bottomButtonTitle = "Step 1: Make Crust";
    });
  }

  @override
  tappedBackButton() {
    _sizeInAnimationController.reverse().whenComplete(() {
      _slideInAnimationController.reverse();
    });
    _fadeInAnimationController.reverse();
    _fadeOutAnimationController.forward().whenComplete(() {
      Navigator.of(context).pop();
    });
  }

  @override
  tappedNextButton() {}

  _configureAnimation() {
    _slideInAnimationController = new AnimationController(
      duration: const Duration(milliseconds: _kSlideInDuration),
      vsync: this,
    );
    _fadeInAnimationController = new AnimationController(
      duration: const Duration(milliseconds: _kFadeInDuration),
      vsync: this,
    );
    _fadeOutAnimationController = new AnimationController(
      duration: const Duration(milliseconds: _kFadeOutDuration),
      vsync: this,
    );
    _sizeInAnimationController = new AnimationController(
      duration: const Duration(milliseconds: _kSizeInDuration),
      vsync: this,
    );
    _slideInLeftAnimation = _initSlideAnimation(
        from: const Offset(2.0, 0.0),
        to: const Offset(0.0, 0.0),
        curve: Curves.easeInOut,
        controller: _slideInAnimationController);
    _slideInRightAnimation = _initSlideAnimation(
        from: const Offset(-2.0, 0.0),
        to: const Offset(0.0, 0.0),
        curve: Curves.easeInOut,
        controller: _slideInAnimationController);
    _slideInUpAnimation = _initSlideAnimation(
        from: const Offset(0.0, 2.0),
        to: const Offset(0.0, 0.0),
        curve: Curves.decelerate,
        controller: _slideInAnimationController);
    _slideInDownAnimation = _initSlideAnimation(
        from: const Offset(0.0, -4.0),
        to: const Offset(0.0, 0.0),
        curve: Curves.decelerate,
        controller: _slideInAnimationController);
    _fadeInAnimation = _initAnimation(
        from: 0.0,
        to: 1.0,
        curve: Curves.linear,
        controller: _fadeInAnimationController);
    _fadeOutAnimation = _initAnimation(
        from: 1.0,
        to: 0.0,
        curve: Curves.easeIn,
        controller: _fadeOutAnimationController);
    _sizeInAnimation = _initAnimation(
        from: 0.0,
        to: 1.0,
        curve: Curves.linear,
        controller: _sizeInAnimationController);
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

  _startAnimation() {
    _slideInAnimationController.forward();
    _fadeInAnimationController.forward();
    _sizeInAnimationController.forward();
  }
}
