// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => new _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with TickerProviderStateMixin {
  static const int _kAnimationInDuration = 300;

  List<Widget> _cells = [];
  bool _isSearching = false;

  Animation<double> _scaleInAnimation;
  AnimationController _animationController;

  // TODO(al) - Implement indexing
  final TextEditingController _searchQuery = new TextEditingController();
  _SearchScreenState() {
    _cells = _loadResults();
  }

  @override
  Widget build(BuildContext context) {
    return _contentWidget();
  }

  @override
  dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  initState() {
    super.initState();
    _configureAnimation();
    _animationController.forward();
  }

  Widget _buildAppBar() {
    return new Material(
      color: const Color(0x00FFFFFF),
      child: new Container(
        height: 80.0,
        padding: const EdgeInsets.only(left: 10.0, top: 15.0),
        child: new Align(
          alignment: FractionalOffset.centerLeft,
          child: new Container(
            child: new IconButton(
              icon: new Icon(
                Icons.close,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputWidget() {
    return new Container(
      padding: const EdgeInsets.only(left: 25.0, right: 26.0),
      height: 64.0,
      child: new TextField(
        decoration: new InputDecoration(
          hintText: "Search Flutter",
          hintStyle: new TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 24.0,
            color: const Color(0x80FFFFFF),
          ),
        ),
        style: new TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 24.0,
          color: Colors.white,
        ),
        onChanged: (String newValue) {
          setState(() {
            print("Search: $newValue");
          });
        },
      ),
    );
  }

  _configureAnimation() {
    _animationController = new AnimationController(
      duration: const Duration(milliseconds: _kAnimationInDuration),
      vsync: this,
    );
    _scaleInAnimation = _initAnimation(
        from: 0.0,
        to: 1.0,
        curve: Curves.easeOut,
        controller: _animationController);
  }

  Widget _contentWidget() {
    return new Container(
      color: const Color(0x00FFFFFF),
      child: new ScaleTransition(
        scale: _scaleInAnimation,
        child: new Material(
          color: Theme.of(context).primaryColor,
          child: new Column(
            children: [
              _buildAppBar(),
              _buildInputWidget(),
              _resultsViewWidget(),
            ],
          ),
        ),
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

  List<Widget> _loadResults() {
    List<Widget> resultCells = [];
    for (int i = 0; i < 3; i++) {
      final resultContainer = new Container(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 20.0),
        height: 64.0,
        child: new Text("Search Result",
            style: new TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 18.0,
              color: Colors.white,
            )),
      );
      resultCells.add(resultContainer);
    }
    return resultCells;
  }

  Widget _resultsViewWidget() {
    return new Expanded(
      child: new Container(
        child: new Padding(
          padding: const EdgeInsets.only(top: 0.0, bottom: 10.0),
          child: new ListView(
            children: _cells,
          ),
        ),
      ),
    );
  }
}
