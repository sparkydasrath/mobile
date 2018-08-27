// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:posse_gallery/models/checklist.dart';
import 'package:posse_gallery/models/checklist_item.dart';
import 'package:posse_gallery/models/category_item.dart';
import 'package:posse_gallery/screens/item_screen.dart';

class PatternsListDetail extends StatefulWidget {
  PatternsListDetail({this.checklistItem});

  @override
  _PatternsListDetailState createState() =>
      new _PatternsListDetailState(checklistItem: this.checklistItem);

  final ChecklistItem checklistItem;
}

class _PatternsListDetailState extends State<PatternsListDetail> {

  _PatternsListDetailState({this.checklistItem});

  final TextEditingController _notesTextController = new TextEditingController();
  final ChecklistItem checklistItem;

  Widget _buildTitle() {
    return new Container(
      color: const Color(0xFFF7F7F7),
      height: 60.0,
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          new Expanded(
            child: new Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: new Text(
                checklistItem.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: new TextStyle(
                  fontSize: 16.0,
                  color: const Color(0xFF717171),
                  fontWeight: FontWeight.bold,),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompletionCheckbox() {
    return new Container(
      decoration: new BoxDecoration(
        border: new Border(
          bottom: new BorderSide(
            color: const Color(0xFFF4F4F4),
            width: 1.0,
          ),
        ),
      ),
      height: 60.0,
      child: new Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0.0),
        child: new Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            new Checkbox(
              value: checklistItem.isSelected,
              onChanged: (bool value) {
                setState(() {
                  checklistItem.isSelected = value;
                });
              },
            ),
            new Expanded(
              child: new Text(
                "Completed",
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotesHeader() {
    return new Container(
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          new Expanded(
            child: new Padding(
              padding: const EdgeInsets.only(
                left: 16.0, right: 16.0, top: 24.0, bottom: 8.0,),
              child: new Text(
                "Notes",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: new TextStyle(
                  fontSize: 16.0,
                  color: const Color(0xFF9B9B9B),
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotesSection() {
    _notesTextController.text = checklistItem.note;
    return new Container(
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          new Expanded(
            child: new Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: new TextField(
                maxLines: 5,
                controller: _notesTextController,
                onChanged: (newValue) {
                  checklistItem.note = newValue;
                },
                decoration: new InputDecoration(
                  isDense: true,
                  hintText: 'Enter additional details',
                  border: null,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _contentWidget() {
    return new Column(
      children: [
        _buildTitle(),
        _buildCompletionCheckbox(),
        _buildNotesHeader(),
        _buildNotesSection(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Material(
      color: const Color(0xFFFFFFFF),
      child: _contentWidget(),
    );
  }

}
