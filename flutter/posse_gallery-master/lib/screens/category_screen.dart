// ignore: invalid_constant
// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:posse_gallery/managers/category_manager.dart';
import 'package:posse_gallery/managers/route_manager.dart';
import 'package:posse_gallery/models/app_category.dart';
import 'package:posse_gallery/models/category_item.dart';
import 'package:posse_gallery/physics/snapping_scroll_physics.dart';
import 'package:posse_gallery/screens/item_screen.dart';

class CategoryScreen extends StatefulWidget {
  final AppCategory _category;

  CategoryScreen({
    AppCategory category,
  })
      : _category = category;

  @override
  _CategoryScreenState createState() =>
      new _CategoryScreenState(category: _category);
}

class _CategoryScreenState extends State<CategoryScreen>
    with SingleTickerProviderStateMixin {
  static const int _kAnimationDuration = 500;

  final AppCategory _category;
  List<Widget> _cells;
  String _categoryTitle = "";

  AnimationController _animationController;

  _CategoryScreenState({
    AppCategory category,
  })
      : _category = category;

  @override
  Widget build(BuildContext context) {
    return new Material(
      color: _category.centerShapeColor,
      child: new Center(
        child: _contentWidget(),
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
      _cells = _loadItems();
    });
  }

  Widget _appBarCategoryView() {
    String categoryIndex = new CategoryManager().indexOfCategory(_category);
    return new Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        new Center(
          child: new Text(
            categoryIndex,
            textAlign: TextAlign.center,
            style: new TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 10.0,
              color: Colors.white,
            ),
          ),
        ),
        new Padding(
          padding: const EdgeInsets.only(
              left: 30.0, right: 30.0, top: 15.0, bottom: 15.0),
          child: new Text(
            _category.title.toUpperCase(),
            textAlign: TextAlign.center,
            style: new TextStyle(
              fontWeight: FontWeight.w700,
              letterSpacing: 1.1,
              height: 1.3,
              fontSize: 30.0,
              color: Colors.white,
            ),
          ),
        ),
        new Container(
          height: 3.0,
          width: 35.0,
          color: Colors.white,
        ),
        new Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
          child: new Text(
            _category.subtitle,
            textAlign: TextAlign.center,
            style: new TextStyle(
              fontWeight: FontWeight.w700,
              letterSpacing: 1.1,
              height: 1.3,
              fontSize: 14.0,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAppBar() {
    return new Hero(
      tag: _category.title,
      child: new Container(
        height: 256.0,
        child: new Material(
          color: const Color(0x00FFFFFF),
          child: new DecoratedBox(
            decoration: new BoxDecoration(),
            child: new Stack(
              children: [
                new Positioned.fill(
                  child: new Container(color: _category.centerShapeColor),
                ),
                new Positioned(
                  right: -20.0,
                  bottom: -10.0,
                  child: new Image(
                    height: 300.0,
                    width: 300.0,
                    color: _category.rightShapeColor,
                    image: new AssetImage(
                        "assets/images/category_cell_right_shape.png"),
                    fit: BoxFit.cover,
                  ),
                ),
                new Positioned(
                  left: 0.0,
                  bottom: -40.0,
                  child: new Image(
                    height: 300.0,
                    width: 350.0,
                    color: _category.leftShapeColor,
                    image: new AssetImage(
                        "assets/images/category_cell_left_shape.png"),
                    fit: BoxFit.cover,
                  ),
                ),
                new Center(
                  child: new Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: _appBarCategoryView(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBackButton() {
    TargetPlatform platform = Theme.of(context).platform;
    final IconData backIcon = platform == TargetPlatform.android
        ? Icons.arrow_back
        : Icons.arrow_back_ios;
    return new IconButton(
      padding: EdgeInsets.zero,
      icon: new Icon(Icons.close, color: Colors.white),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }

  _configureAnimation() {
    _animationController = new AnimationController(
      duration: const Duration(milliseconds: _kAnimationDuration),
      vsync: this,
    );
  }

  Widget _contentWidget() {
    double expandedAppBarHeight = 256.0;
    double threshold =
        MediaQuery.of(context).size.height - expandedAppBarHeight - MediaQuery.of(context).padding.top;
    return new Scaffold(
      backgroundColor: _category.centerShapeColor,
      body: new NotificationListener<ScrollNotification>(
        onNotification: _handleScrollNotification,
        child: new CustomScrollView(
          slivers: [
            new SliverAppBar(
              pinned: true,
              title: new Text(
                _categoryTitle,
                style: new TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 20.0,
                ),
              ),
              expandedHeight: expandedAppBarHeight,
              leading: _buildBackButton(),
              backgroundColor: _category.centerShapeColor.withAlpha(255),
              flexibleSpace: new FlexibleSpaceBar(
                background: _buildAppBar(),
              ),
            ),
            new SliverList(
              delegate: new SliverChildListDelegate(_cells),
            ),
          ],
        ),
      ),
    );
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    double visibleStatsHeight = notification.metrics.pixels;
    double screenHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    double visiblePercentage = visibleStatsHeight / screenHeight;
    _categoryTitle = visiblePercentage > 0.3 ? _category.title : "";
    setState(() {});
    return false;
  }

  Widget _createCell({@required CategoryItem item}) {
    String routeName = item.routeName;
    Color color = item.color;
    Color textColor = item.title == "COMPONENTS" ? Colors.black : Colors.white;
    return new Container(
      color: color,
      height: 163.0,
      child: new Stack(
        children: [
          new Center(
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                new Padding(
                  padding: const EdgeInsets.only(left: 50.0),
                  child: new Image(
                    width: 50.0,
                    image: new AssetImage(item.iconUri),
                    fit: BoxFit.scaleDown,
                  ),
                ),
                new Expanded(
                  child: new Padding(
                    padding: const EdgeInsets.only(left: 50.0, right: 20.0),
                    child: new Text(
                      item.title,
                      style: new TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14.0,
                        height: 1.3,
                        color: textColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          new Material(
            color: const Color(0x00FFFFFF),
            child: new InkWell(
              highlightColor: Colors.white.withAlpha(30),
              splashColor: Colors.white.withAlpha(20),
              onTap: () {
                Widget nextScreen;
                if (item.needsFullScreen == true) {
                  nextScreen = item.widget;
                } else {
                  nextScreen = new ItemScreen(
                      item:
                          RouteManager.retrieveItem(_category, item.routeName));
                }
                Navigator.push(
                  context,
                  new MaterialPageRoute<Null>(
                    settings: new RouteSettings(name: "/item/$routeName"),
                    builder: (BuildContext context) {
                      return nextScreen;
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
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

  List<Widget> _loadItems() {
    List<Widget> cells = [];
    for (int i = 0; i < _category.categoryItems.length; i++) {
      CategoryItem item = _category.categoryItems[i];
      Animation<Offset> animation = _initSlideAnimation(
        from: new Offset(0.0, (i + 1).toDouble()),
        to: const Offset(0.0, 0.0),
        curve: Curves.easeOut,
        controller: _animationController,
      );
      final cellContainer = new SlideTransition(
        position: animation,
        child: _createCell(item: item),
      );
      cells.add(cellContainer);
    }
    return cells;
  }
}
