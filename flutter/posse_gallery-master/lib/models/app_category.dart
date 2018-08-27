// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/painting.dart';
import 'package:posse_gallery/models/category_item.dart';

class AppCategory {
  AppCategory({
    this.routeName,
    this.title,
    this.subtitle,
    this.leftShapeColor,
    this.centerShapeColor,
    this.rightShapeColor,
    this.categoryItems,
  });

  final String routeName;
  final String title;
  final String subtitle;
  final Color leftShapeColor;
  final Color centerShapeColor;
  final Color rightShapeColor;
  final List<CategoryItem> categoryItems;
}
