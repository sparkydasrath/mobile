import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'category.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Unit Converter',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green[100],
          title:
              Text('Unit Converter', style: Theme.of(context).textTheme.title),
          elevation: 0.0,
        ),
        body: MyWidget(),
        backgroundColor: Colors.green[100],
      ),
    );
  }
}

List<Category> _buildCategories() {
  List<Category> _categories = <Category>[];
  _categories.add(
      Category(name: 'Length', color: Colors.green, iconType: Icons.ac_unit));
  _categories.add(
      Category(name: 'Area', color: Colors.blue, iconType: Icons.markunread));
  _categories.add(Category(
      name: 'Speed', color: Colors.red, iconType: Icons.shutter_speed));
  _categories.add(Category(
      name: 'Distance', color: Colors.yellow, iconType: Icons.shutter_speed));
  _categories.add(Category(
      name: 'Volume', color: Colors.orange, iconType: Icons.shutter_speed));
  _categories.add(Category(
      name: 'Mass', color: Colors.purple, iconType: Icons.shutter_speed));
  _categories.add(Category(
      name: 'Time', color: Colors.white, iconType: Icons.shutter_speed));
  _categories.add(Category(
      name: 'Storage', color: Colors.red, iconType: Icons.shutter_speed));

  return _categories;
}

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Category> _categories = _buildCategories();

    return ListView.builder(
      itemCount: _categories.length,
      itemBuilder: (context, int i) => _categories[i],
    );
  }
}
