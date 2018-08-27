// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

class ChecklistItem {
  ChecklistItem({this.title, this.note, this.isSelected});

  String title;
  String note;
  bool isSelected;
}