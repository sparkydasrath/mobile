// ignore: invalid_constant
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:posse_gallery/config/constants.dart';
import 'package:posse_gallery/managers/welcome_manager.dart';
import 'package:posse_gallery/screens/main_screen.dart';

class SecondaryWidgetHolder {
  SecondaryWidgetHolder(
      {this.top, this.right, this.bottom, this.left, @required this.child});

  double top;
  double right;
  double bottom;
  double left;
  Widget child;
}

class WarmWelcomeScreen extends StatefulWidget {
  WarmWelcomeScreen({Key key, this.isInitialScreen = true}) : super(key: key);

  final bool
      isInitialScreen; // is the screen being displayed as a demo item or not?

  @override
  _WarmWelcomeScreenState createState() =>
      new _WarmWelcomeScreenState(isInitialScreen: isInitialScreen);
}

class _WarmWelcomeScreenState extends State<WarmWelcomeScreen>
    with TickerProviderStateMixin {
  _WarmWelcomeScreenState({this.isInitialScreen});

  static const int _kParallaxAnimationDuration = 400;
  bool isInitialScreen =
      true; // is the screen being displayed as a demo item or not?

  var _steps = new WelcomeManager().steps();
  TabController _tabController;
  int _currentPage = 0; // for page indicator
  double _bgOffset = 0.0;

  // animations
  List<AnimationController> _inAnimationControllers = <AnimationController>[];
  List<AnimationController> _outAnimationControllers = <AnimationController>[];
  Map<int, AnimationController> _secondaryAnimationControllers = <int, AnimationController>{};
  AnimationController _parallaxController;

  _makeAnimatedContentWidget({Widget child}) {
    // out animation
    final outAnimationController = new AnimationController(
      duration: new Duration(milliseconds: 200),
      vsync: this,
    );
    Animation<double> outScaleAnimation = new CurvedAnimation(
      parent: outAnimationController,
      curve: Curves.easeOut,
    );
    final outScaleTween = new Tween(
      begin: 1.0,
      end: 0.0,
    ).animate(outScaleAnimation);
    Animation<double> slideAnimation = new CurvedAnimation(
      parent: outAnimationController,
      curve: Curves.easeOut,
    );
    final outSlideTween = new Tween(
      begin: const Offset(0.0, 0.0),
      end: const Offset(1.0, 0.0),
    ).animate(slideAnimation);
    _outAnimationControllers.add(outAnimationController);

    // in animation
    final inAnimationController = new AnimationController(
      duration: new Duration(milliseconds: 200),
      vsync: this,
    );
    Animation<double> inScaleAnimation = new CurvedAnimation(
      parent: inAnimationController,
      curve: Curves.linear,
    );
    final inScaleTween = new Tween(
      begin: 0.6,
      end: 1.0,
    ).animate(inScaleAnimation);
    _inAnimationControllers.add(inAnimationController);

    // widgets
    var outAnimationWrapper = new SlideTransition(
      position: outSlideTween,
      child: new ScaleTransition(
        scale: outScaleTween,
        child: child,
      ),
    );
    var inAnimationWrapper = new ScaleTransition(
      scale: inScaleTween,
      child: outAnimationWrapper,
    );
    return inAnimationWrapper;
  }

  _contentWidget(
      {Widget contentChild,
      String title,
      String subtitle,
      bool hasSecondary = false,
      int pageIndex}) {
    var contentStackChildren = <Widget>[];
    contentStackChildren.add(contentChild);
    if (hasSecondary) {
      contentStackChildren.addAll(_secondaryWidgets(pageIndex));
    }

    var stackChildren = <Widget>[
      new Positioned.fill(
        top: 65.0,
        child: new Padding(
          padding: new EdgeInsets.only(left: 45.0, right: 45.0),
          child: new Column(
            children: <Widget>[
              new Text(
                title,
                textAlign: TextAlign.center,
                style: new TextStyle(
                  fontSize: 22.0,
                  color: const Color(Constants.ColorPrimary),
                  letterSpacing: 0.25,
                ),
              ),
              new Padding(
                padding: new EdgeInsets.only(top: 10.0),
                child: new Text(subtitle, textAlign: TextAlign.center),
              ),
            ],
          ),
        ),
      ),
      new Center(
        child: _makeAnimatedContentWidget(
            child: new Container(
          width: 300.0,
          height: 300.0,
          child: new Stack(
            children: contentStackChildren,
          ),
        )),
      ),
    ];

    return new Stack(
      children: stackChildren,
    );
  }

  _secondaryWidgets(int index) {
    var holders = <SecondaryWidgetHolder>[];
    var widgets = <Widget>[];

    if (index == 2) {
      AnimationController controller = new AnimationController(
        duration: new Duration(milliseconds: 750),
        vsync: this,
      );
      _secondaryAnimationControllers[index] = controller;

      var begins = <double>[0.0, 0.55, 0.25, 0.75];
      var ends = <double>[0.5, 1.0, 0.75, 1.0];
      var scaleAnimations = <int, Animation<double>>{};
      for (int a = 0; a < 4; a++) {
        Animation<double> scaleAnimation = new CurvedAnimation(
          parent: controller,
          curve: new Interval(begins[a], ends[a], curve: Curves.easeIn),
        );
        final scaleTween = new Tween(
          begin: 0.0,
          end: 1.0,
        ).animate(scaleAnimation);
        scaleAnimations[a] = scaleTween;
      }

      holders = <SecondaryWidgetHolder>[
        new SecondaryWidgetHolder(
          top: 25.0,
          left: 10.0,
          child: new ScaleTransition(
            scale: scaleAnimations[0],
            child: new Image(
              height: 55.0,
              image: new AssetImage(_steps[index].imageUris[1]),
            ),
          ),
        ),
        new SecondaryWidgetHolder(
          top: 70.0,
          right: 30.0,
          child: new ScaleTransition(
            scale: scaleAnimations[1],
            child: new Image(
              height: 40.0,
              image: new AssetImage(_steps[index].imageUris[2]),
            ),
          ),
        ),
        new SecondaryWidgetHolder(
          bottom: 70.0,
          left: 25.0,
          child: new ScaleTransition(
            scale: scaleAnimations[2],
            child: new Image(
              height: 35.0,
              image: new AssetImage(_steps[index].imageUris[3]),
            ),
          ),
        ),
        new SecondaryWidgetHolder(
          bottom: 10.0,
          right: 55.0,
          child: new ScaleTransition(
            scale: scaleAnimations[3],
            child: new Image(
              height: 30.0,
              image: new AssetImage(_steps[index].imageUris[4]),
            ),
          ),
        ),
      ];
    } else if (index == 3) {
      AnimationController controller = new AnimationController(
        duration: new Duration(milliseconds: 750),
        vsync: this,
      );
      _secondaryAnimationControllers[index] = controller;

      var begins = <double>[0.0, 0.55, 0.25, 0.75, 0.3];
      var ends = <double>[0.5, 1.0, 0.75, 1.0, 0.9];
      var scaleAnimations = <int, Animation<double>>{};
      for (int a = 0; a < 5; a++) {
        Animation<double> scaleAnimation = new CurvedAnimation(
          parent: controller,
          curve: new Interval(begins[a], ends[a], curve: Curves.easeIn),
        );
        final scaleTween = new Tween(
          begin: 0.0,
          end: 1.0,
        ).animate(scaleAnimation);
        scaleAnimations[a] = scaleTween;
      }

      holders = <SecondaryWidgetHolder>[
        new SecondaryWidgetHolder(
          top: 35.0,
          left: 10.0,
          child: new ScaleTransition(
            scale: scaleAnimations[0],
            child: new Image(
              height: 50.0,
              image: new AssetImage(_steps[index].imageUris[1]),
            ),
          ),
        ),
        new SecondaryWidgetHolder(
          top: 30.0,
          right: 20.0,
          child: new ScaleTransition(
            scale: scaleAnimations[1],
            child: new Image(
              height: 60.0,
              image: new AssetImage(_steps[index].imageUris[2]),
            ),
          ),
        ),
        new SecondaryWidgetHolder(
          top: 135.0,
          right: 35.0,
          child: new ScaleTransition(
            scale: scaleAnimations[2],
            child: new Image(
              height: 35.0,
              image: new AssetImage(_steps[index].imageUris[3]),
            ),
          ),
        ),
        new SecondaryWidgetHolder(
          bottom: 30.0,
          left: 18.0,
          child: new ScaleTransition(
            scale: scaleAnimations[3],
            child: new Image(
              height: 30.0,
              image: new AssetImage(_steps[index].imageUris[4]),
            ),
          ),
        ),
        new SecondaryWidgetHolder(
          bottom: 20.0,
          right: 30.0,
          child: new ScaleTransition(
            scale: scaleAnimations[4],
            child: new Image(
              height: 65.0,
              image: new AssetImage(_steps[index].imageUris[5]),
            ),
          ),
        ),
      ];
    }

    for (int i = 0; i < holders.length; i++) {
      SecondaryWidgetHolder holder = holders[i];
      widgets.add(
        new Positioned(
          top: holder.top,
          right: holder.right,
          bottom: holder.bottom,
          left: holder.left,
          child: holder.child,
        ),
      );
    }
    return widgets;
  }

  _pageIndicator() {
    _tabController = new TabController(initialIndex: 0, length: 4, vsync: this);
    return new TabPageSelector(controller: _tabController);
  }

  _continueButton() {
    return new Container(
      width: 200.0,
      height: 54.0,
      child: new RaisedButton(
        color: const Color(Constants.ColorPrimary),
        child: new Text(
          "START EXPLORING",
          style: new TextStyle(
            color: const Color(0xFFFFFFFF),
            fontSize: 12.0,
          ),
        ),
        onPressed: _tappedContinue,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final children = <Widget>[];
    for (int i = 0; i < _steps.length; i++) {
      children.add(
        _contentWidget(
          contentChild: new Center(
            child: new Padding(
              padding: const EdgeInsets.only(top: 27.0),
              child: new Image(
                  width: math.min(280.0, MediaQuery.of(context).size.width),
                  fit: BoxFit.fitHeight,
                  image: new AssetImage(_steps[i].imageUris[0]),
              ),
            ),
          ),
          title: _steps[i].title,
          subtitle: _steps[i].subtitle,
          hasSecondary: i == 2 || i == 3,
          pageIndex: i,
        ),
      );
    }

    double startPixels = 0.0;
    final screenWidth = MediaQuery.of(context).size.width;

    _inAnimationControllers[0].value = 1.0;

    return new Material(
      color: new Color(0xFFFFFFFF),
      child: new NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification notification) {
          if (notification is ScrollStartNotification) {
            final PageMetrics metrics = notification.metrics;
            startPixels = metrics.pixels;
            var secondaryAnimationController =
                _secondaryAnimationControllers[_currentPage];
            if (secondaryAnimationController != null &&
                secondaryAnimationController.value != 0) {
              secondaryAnimationController.duration =
                  new Duration(milliseconds: 150);
              secondaryAnimationController.reverse();
            }
          } else if (notification is ScrollUpdateNotification) {
            final PageMetrics metrics = notification.metrics;
            final int page = (metrics.pixels / screenWidth).floor();
            final offset = (metrics.pixels - (page * screenWidth))
                .clamp(0, double.MAX_FINITE);
            _outAnimationControllers[page].value = (offset / screenWidth);
            if (page < (_inAnimationControllers.length - 1)) {
              _inAnimationControllers[page + 1].value = (offset / screenWidth);
            }
            var moveDelta = startPixels < metrics.pixels ? 1 : -1;
            _parallaxController.value += moveDelta * 0.001;
          } else if (notification is ScrollEndNotification) {
            final PageMetrics metrics = notification.metrics;
            _currentPage = metrics.page.round();
            var secondaryAnimationController =
                _secondaryAnimationControllers[_currentPage];
            if (secondaryAnimationController != null) {
              secondaryAnimationController.value = 0.0;
              secondaryAnimationController.duration =
                  new Duration(milliseconds: 450);
              secondaryAnimationController.forward();
            }
            _tabController.animateTo(_currentPage);
          }
          return false;
        },
        child: new Stack(
          children: <Widget>[
            new Positioned.fill(
              child: _backgroundView(),
            ),
            new Positioned.fill(
              child: new PageView(
                children: children,
              ),
            ),
            new Align(
              alignment: FractionalOffset.bottomCenter,
              child: new Padding(
                padding: new EdgeInsets.only(bottom: 40.0),
                child: new Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    new Padding(
                      padding: new EdgeInsets.only(bottom: 20.0),
                      child: _pageIndicator(),
                    ),
                    _continueButton()
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _backgroundView() {
    _parallaxController = new AnimationController(
      duration: new Duration(milliseconds: 200),
      vsync: this,
    );
    var parallaxAnimation = new CurvedAnimation(
      parent: _parallaxController,
      curve: Curves.easeOut,
    );
    final parallaxTween = new Tween(
      begin: const Offset(0.0, 0.0),
      end: const Offset(-1.0, 0.0),
    ).animate(parallaxAnimation);


    return new Stack(
      children: [
        new DecoratedBox(
          decoration: new BoxDecoration(
            gradient: new LinearGradient(
              colors: [
                const Color(0xFFD7D7D7),
                const Color(0xFFFAFAFA),
                const Color(0xFFFFFFFF),
              ],
              begin: FractionalOffset.topCenter,
              end: FractionalOffset.bottomCenter,
              stops: [0.0, 0.35, 1.0],
            ),
          ),
        ),
        new SlideTransition(
          position: parallaxTween,
          child: new Image(
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.cover,
            alignment: FractionalOffset.topLeft,
            image: new AssetImage("assets/backgrounds/bg_flutter_welcome.png"),
          ),
        ),
      ],
    );
  }

  // actions
  _tappedContinue() {
    if (isInitialScreen) {
      Navigator.pushReplacement(
        context,
        new PageRouteBuilder<Null>(
          settings: const RouteSettings(name: "/main"),
          pageBuilder: (BuildContext context, Animation<double> _,
              Animation<double> __) {
            return new MainScreen();
          },
        ),
      );
    } else {
      Navigator.of(context).pop();
    }
  }
}
