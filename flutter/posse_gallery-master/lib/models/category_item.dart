// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/widgets.dart';

class CategoryItem {
  CategoryItem(
      {this.title,
      this.iconUri,
      this.routeName,
      this.color,
      this.widget,
      this.needsFullScreen,
      this.showMoreButton = false});

  final String title;
  final String iconUri;
  final String routeName;
  final Color color;
  final Widget widget;
  final bool needsFullScreen;
  final bool showMoreButton;
}
