// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:posse_gallery/models/checklist.dart';
import 'package:posse_gallery/models/checklist_item.dart';
import 'package:posse_gallery/models/category_item.dart';
import 'package:posse_gallery/screens/item_screen.dart';
import 'package:posse_gallery/screens/demos/patterns/check_list_detail.dart';

typedef void ChecklistItemChangedCallback(ChecklistItem checklistItem,
    bool value);

class ChecklistListItem extends StatelessWidget {
  ChecklistListItem({
    Key key,
    this.animation,
    this.checklistItem,
    this.onTap,
    this.onCheckboxChanged,
  }) : super(key: key) {
    assert(animation != null);
  }

  final Animation<double> animation;
  final ChecklistItem checklistItem;
  final VoidCallback onTap;
  final ChecklistItemChangedCallback onCheckboxChanged;


  @override
  Widget build(BuildContext context) {
    final cellContainer = new SizeTransition(
      axis: Axis.vertical,
      sizeFactor: animation,
      child:
      new Container(
        decoration: new BoxDecoration(
          border: new Border(
            bottom: new BorderSide(
              color: const Color(0xFFF4F4F4),
              width: 1.0,
            ),
          ),
        ),
        height: 60.0,
        child: new Stack(
          children: [
            new Material(
              color: const Color(0x00FFFFFF),
              child: new InkWell(
                highlightColor: Colors.grey.withAlpha(30),
                splashColor: Colors.grey.withAlpha(20),
                onTap: (() {
                  this.onTap();
                }),
              ),
            ),
            new Positioned(
              left: 0.0,
              top: 0.0,
              right: 10.0,
              bottom: 0.0,
              child: new Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  new Checkbox(
                    value: checklistItem.isSelected,
                    onChanged: (bool value) {
                      onCheckboxChanged(checklistItem, value);
                    },
                  ),
                  new Expanded(
                    child: new IgnorePointer(
                      ignoring: true,
                      child: new Text(
                        checklistItem.title,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

    return cellContainer;
  }
}

// Keeps a Checklist in sync with the AnimatedList that is used.
class AnimatedChecklist extends Checklist {
  // todo (kg) - make required params required with @required annotation
  AnimatedChecklist({List<ChecklistItem> items,
    this.removedItemBuilder,
    this.listKey}) : super(items: items);

  final dynamic removedItemBuilder;
  final GlobalKey<AnimatedListState> listKey;

  AnimatedListState get _animatedList => listKey.currentState;

  @override
  void addItem(ChecklistItem item, {int index = -1}) {
    super.addItem(item, index: index);
    if (index == -1) {
      _animatedList.insertItem(items().length);
    } else {
      _animatedList.insertItem(index);
    }
  }
}

class PatternsList extends StatefulWidget {
  @override
  _PatternsListState createState() => new _PatternsListState();
}

class _PatternsListState extends State<PatternsList>
    with TickerProviderStateMixin {

  final TextEditingController _controller = new TextEditingController();
  final GlobalKey<AnimatedListState> _listKey = new GlobalKey<AnimatedListState>();
  AnimatedChecklist _checklist;

  @override
  void initState() {
    super.initState();
    List<ChecklistItem> defaultItems = [
      new ChecklistItem(title: "Drink a gallon of water", isSelected: false),
      new ChecklistItem(title: "Read a novel", isSelected: false),
      new ChecklistItem(title: "Learn a new language", isSelected: false),
      new ChecklistItem(title: "Visit a new place", isSelected: false),
    ];

    _checklist = new AnimatedChecklist(
        listKey: _listKey,
        removedItemBuilder: _buildRemovedItem,
        items: defaultItems,
    );
  }

  // Used to build list items that haven't been removed.
  Widget _buildItem(BuildContext context, int index, Animation<double> animation) {
    return new ChecklistListItem(
      animation: animation,
      checklistItem: _checklist[index],
      onTap: () {
        print("tapped");
        Navigator.push(
          context,
          new MaterialPageRoute<Null>(
            fullscreenDialog: false,
            settings:
            new RouteSettings(),
            builder: (BuildContext context) {
              var item = new CategoryItem(
                  title: "MAKE A LIST",
                  iconUri: "assets/icons/ic_patterns_list.png",
                  routeName: "patterns_list",
                  color: const Color(0xFFFF8B00),
                  widget: new PatternsListDetail(
                    checklistItem: _checklist[index],));
              return new ItemScreen(item: item);
            },
          ),
        );
      },
      onCheckboxChanged: (checklistItem, value) {
        setState(() {
          checklistItem.isSelected = value;
        });
      },
    );
  }

  // Used to build an item after it has been removed from the list.
  Widget _buildRemovedItem(ChecklistItem item, BuildContext context, Animation<double> animation) {
    return new ChecklistListItem(
      animation: animation,
      checklistItem: item,
    );
  }

  Widget _buildInputField() {
    return new Container(
      color: const Color(0xFFF7F7F7),
      height: 60.0,
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          new Material(
            color: new Color(0xFFF7F7F7),
            child: new IconButton(
              icon: new Icon(
                Icons.add,
                color: const Color(0xFF54C5F8),
              ),
              onPressed: () {
                if (_controller.text.length > 0) {
                  ChecklistItem item = new ChecklistItem(
                      title: _controller.text, isSelected: false);
                  setState(() {
                    _checklist.addItem(item, index: 0);
                    _controller.clear();
                  });
                }
              },
            ),
          ),
          new Expanded(
            child: new Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: new TextField(
                controller: _controller,
                decoration: new InputDecoration(
                  hintText: 'Enter your note',
                  border: null,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListView() {
    return new Expanded(
      child: new AnimatedList(
        key: _listKey,
        initialItemCount: _checklist.items().length,
        itemBuilder: _buildItem,
      ),
    );
  }

  Widget _contentWidget() {
    return new Column(
      children: [
        _buildInputField(),
        _buildListView(),
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
