// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:posse_gallery/models/app_category.dart';
import 'package:posse_gallery/models/category_item.dart';
import 'package:posse_gallery/screens/demos/assets_demo.dart';
import 'package:posse_gallery/screens/demos/customized_design.dart';
import 'package:posse_gallery/screens/demos/patterns/check_list_screen.dart';
import 'package:posse_gallery/screens/demos/platform_demo.dart';
import 'package:posse_gallery/screens/warm_welcome_screen.dart';

class CategoryManager {
  CategoryManager() {
    _categories = _categoryList;
  }

  static List<AppCategory> _categories;

  List<AppCategory> categories() {
    return _categories;
  }

  String indexOfCategory(AppCategory category) {
    for (int i = 0; i < _categories.length; i++) {
      AppCategory tempCategory = _categories[i];
      if (tempCategory.title == category.title) {
        int adjustedIndex = i + 1;
        return adjustedIndex.toString().padLeft(2, '0');
      }
    }
    return "";
  }

  final List<AppCategory> _categoryList = [
    new AppCategory(
      routeName: "customized_design",
      title: "Customized Design",
      subtitle: "BRAND FIRST EXPERIENCES",
      leftShapeColor: const Color(0xFF19AAEE),
      centerShapeColor: const Color(0xD800A2EE),
      rightShapeColor: const Color(0xFF1AA3E4),
      categoryItems: [
        new CategoryItem(
          title: "FITNESS TRACKER",
          iconUri: "assets/icons/ic_customized_runner.png",
          routeName: "customized_brand_design",
          color: const Color(0xFF30BDFF),
          widget: new CustomizedDesign(),
          needsFullScreen: true,
        ),
        new CategoryItem(
          title: "RECIPE BOOK",
          iconUri: "assets/icons/ic_customized_book.png",
          routeName: "assets_themes",
          color: const Color(0xFF009FEA),
          widget: new AssetsDemo(),
          needsFullScreen: true,
        ),
        new CategoryItem(
          title: "MODERN FURNITURE STORE",
          iconUri: "assets/icons/ic_customized_furniture.png",
          routeName: "painting",
          color: const Color(0xFF0084EA),
          widget: new PlatformDemo(),
          needsFullScreen: true,
        ),
//        new CategoryItem(
//          title: "COMPONENTS",
//          iconUri: "assets/icons/ic_components.png",
//          routeName: "customized_design_components",
//          color: Colors.white,
//        ),
      ],
    ),
//    new AppCategory(
//      routeName: "layout_positioning",
//      title: "Layout & Positioning",
//      subtitle: "EASY TO COMPOSE",
//      leftShapeColor: const Color(0xFF5BDBFF),
//      centerShapeColor: const Color(0xCC45D2F9),
//      rightShapeColor: const Color(0xFF53D2F7),
//      categoryItems: [
//        new CategoryItem(
//          title: "FLEX",
//          iconUri: "assets/icons/ic_layout_flex.png",
//          routeName: "flex",
//          color: const Color(0xFF00BBFF),
//        ),
//        new CategoryItem(
//          title: "STACK",
//          iconUri: "assets/icons/ic_layout_stack.png",
//          routeName: "stack",
//          color: const Color(0xFF0086FF),
//        ),
//        new CategoryItem(
//          title: "SCROLL",
//          iconUri: "assets/icons/ic_layout_scroll.png",
//          routeName: "scroll",
//          color: const Color(0xFF382DFF),
//        ),
//        new CategoryItem(
//          title: "COMPONENTS",
//          iconUri: "assets/icons/ic_components.png",
//          routeName: "layout_components",
//          color: Colors.white,
//        ),
//      ],
//    ),
//    new AppCategory(
//      routeName: "animation",
//      title: "Animation & UI Motion",
//      subtitle: "MADE FOR MOTION",
//      leftShapeColor: const Color(0xFF38D3CD),
//      centerShapeColor: const Color(0xD825C3BC),
//      rightShapeColor: const Color(0xF23BBCB7),
//      categoryItems: [
//        new CategoryItem(
//          title: "TWEENS",
//          iconUri: "assets/icons/ic_animation_tweens.png",
//          routeName: "tweens",
//          color: const Color(0xFF05BBC0),
//        ),
//        new CategoryItem(
//          title: "CHAINS/FRAME",
//          iconUri: "assets/icons/ic_animation_chains.png",
//          routeName: "chains",
//          color: const Color(0xFF00A3A8),
//        ),
//        new CategoryItem(
//          title: "GESTURES",
//          iconUri: "assets/icons/ic_animation_gestures.png",
//          routeName: "gestures",
//          color: const Color(0xFF02898D),
//        ),
//        new CategoryItem(
//          title: "COMPONENTS",
//          iconUri: "assets/icons/ic_components.png",
//          routeName: "animation_components",
//          color: Colors.white,
//        ),
//      ],
//    ),
    new AppCategory(
      routeName: "patterns",
      title: "UI Patterns",
      subtitle: "NATURAL AND PRODUCTIVE",
      leftShapeColor: const Color(0xFFF9B640),
      centerShapeColor: const Color(0xD8FFAC18),
      rightShapeColor: const Color(0xFFFFB02C),
      categoryItems: [
        new CategoryItem(
          title: "MAKE A LIST",
          iconUri: "assets/icons/ic_patterns_list.png",
          routeName: "patterns_list",
          color: const Color(0xFFFF8B00),
          widget: new PatternsList(),
        ),
        new CategoryItem(
          title: "WALKTHROUGH",
          iconUri: "assets/icons/ic_patterns_walkthrough.png",
          routeName: "walkthrough",
          color: const Color(0xFFFF6600),
          widget: new WarmWelcomeScreen(isInitialScreen: false),
          needsFullScreen: true,
        ),
//        new CategoryItem(
//          title: "WALKTHROUGH 2.0",
//          iconUri: "assets/icons/ic_patterns_walkthrough.png",
//          routeName: "walkthrough2.0",
//          color: const Color(0xFFD00B13),
//          widget: new WarmWelcomeScreen2(),
//          needsFullScreen: true,
//        ),
//        new CategoryItem(
//          title: "EDIT AN IMAGE",
//          iconUri: "assets/icons/ic_pattern_edit_image.png",
//          routeName: "edit_image",
//          color: const Color(0xFFFF4A2D),
//        ),
      ],
    ),
//    new AppCategory(
//      routeName: "plug_ins",
//      title: "Plug Ins",
//      subtitle: "UNIFIED BUILDING BLOCKS",
//      leftShapeColor: const Color(0xFFFD734E),
//      centerShapeColor: const Color(0xD8FF6941),
//      rightShapeColor: const Color(0x80FA724E),
//      categoryItems: [
//        new CategoryItem(
//          title: "TAKE A PHOTO",
//          iconUri: "assets/icons/ic_plug_in_photo.png",
//          routeName: "take_photo",
//          color: const Color(0xFFFE5224),
//        ),
//        new CategoryItem(
//          title: "CURRENT LOCATION",
//          iconUri: "assets/icons/ic_plug_in_location.png",
//          routeName: "current_location",
//          color: const Color(0xFFF13300),
//        ),
//        new CategoryItem(
//          title: "DEVICE MOTION",
//          iconUri: "assets/icons/ic_plug_in_motion.png",
//          routeName: "device_motion",
//          color: const Color(0xFFDE0202),
//        ),
//        new CategoryItem(
//          title: "CUSTOM SERVICE PLUG-INS",
//          iconUri: "assets/icons/ic_plug_in_service.png",
//          routeName: "custom_plug_ins",
//          color: const Color(0xFFBA0000),
//        ),
//      ],
//    ),
//    new AppCategory(
//      routeName: "design_components",
//      title: "Design Components",
//      subtitle: "HIGH FIDELITY TOOLKIT",
//      leftShapeColor: const Color(0xFFAFD84C),
//      centerShapeColor: const Color(0xBFA1CB39),
//      rightShapeColor: const Color(0xFFA3CA4B),
//      categoryItems: [
//        new CategoryItem(
//          title: "IOS CONTROLS",
//          iconUri: "assets/icons/ic_design_components_controls.png",
//          routeName: "components_ios_controls",
//          color: const Color(0xFF8ABC10),
//        ),
//        new CategoryItem(
//          title: "MATERIAL CONTROLS",
//          iconUri: "assets/icons/ic_design_components_material.png",
//          routeName: "components_material_controls",
//          color: const Color(0xFF6AAD10),
//        ),
//      ],
//    ),
  ];
}
