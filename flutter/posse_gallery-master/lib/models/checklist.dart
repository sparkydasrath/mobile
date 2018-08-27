import 'package:posse_gallery/models/checklist_item.dart';

class Checklist {

  Checklist({List<ChecklistItem> items}) : this._items = items;

  // properties
  List<ChecklistItem> _items = <ChecklistItem>[];

  ChecklistItem operator [](int index) => _items[index];

  // methods
  List<ChecklistItem> items() { return _items; }

  void clear() {
    _items = <ChecklistItem>[];
  }

  void addItem(ChecklistItem item, {int index = -1}) {
    if (index == -1) {
      _items.add(item);
    } else {
      _items.insert(index, item);
    }
  }

  void removeItemAtIndex(int index) {
    _items.removeAt(index);
  }

  void removeItem(ChecklistItem item) {
    _items.remove(item);
  }

}