// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:posse_gallery/config/app_settings.dart';
import 'package:posse_gallery/config/application.dart';
import 'package:posse_gallery/config/constants.dart';
import 'package:posse_gallery/managers/route_manager.dart';
import 'package:posse_gallery/notifications/notifications.dart';
import 'package:posse_gallery/screens/main_screen.dart';
import 'package:posse_gallery/screens/warm_welcome_screen.dart';
import 'package:fluro/fluro.dart';

void main() {
  runApp(new GalleryApp());
}

class GalleryApp extends StatefulWidget {

  GalleryApp({
    this.enablePerformanceOverlay = false,
    this.checkerboardRasterCacheImages = false,
  });

  // debug
  final bool enablePerformanceOverlay;
  final bool checkerboardRasterCacheImages;

  @override
  _GalleryAppState createState() {
    return new _GalleryAppState();
  }
}

class _GalleryAppState extends State<GalleryApp> {

  Widget mainWidget;
  final Router router = new Router();

  // debug
  bool _showPerformanceOverlay = false;
  bool _checkerboardRasterCacheImages = false;
  bool _configChanged = false;

  _GalleryAppState() {
    // routes
    RouteManager routeManager = new RouteManager();
    routeManager.configureRoutes(router);
    Application.router = router;
    _showPerformanceOverlay = Application.enablePerformanceOverlay;
    _checkerboardRasterCacheImages = Application.enablePerformanceOverlay;

    mainWidget = loadingWidget();
    configureApp().then((Widget configuredWidget) {
      setState(() {
        mainWidget = configuredWidget;
      });
    });
  }

  Widget loadingWidget() {
    return new Material();
  }

  Future<Widget> configureApp() async {
    // ready the global app settings reference
    Application.settings = await new PersistedAppSettings().load();
    return configureUI();
  }

  Widget configureUI() {
    bool hasSeenWelcome = Application.settings
        .boolValue(Constants.ConfigKeySeenWelcome, defaultValue: false);
    Widget launchScreen =
    !hasSeenWelcome ? new WarmWelcomeScreen(isInitialScreen: true) : new MainScreen();

    return new NotificationListener<DebugOptionChangedNotification>(
      onNotification: (notification) {
        setState(() {
          _showPerformanceOverlay = Application.enablePerformanceOverlay;
          _checkerboardRasterCacheImages = Application.checkerboardRasterCacheImages;
          _configChanged = true;
        });
        return true;
      },
      child: new MaterialApp(
        // debug
        showPerformanceOverlay: _showPerformanceOverlay,
        checkerboardRasterCacheImages: _checkerboardRasterCacheImages,

        // main app configuration
        title: 'Flutter Gallery',
        theme: new ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: launchScreen,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_configChanged) {
      mainWidget = configureUI();
      _configChanged = false;
    }
    return mainWidget;
  }

}
