import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  MyAppState createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  final items = List<String>.generate(3, (i) => "Item ${i + 1}");
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Dismissible list",
      home: Scaffold(
        appBar: AppBar(
          title: Text("dismissible item"),
        ),
        body: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return Dismissible(
                  key: Key(item),
                  onDismissed: (direction) {
                    setState(() {
                      items.removeAt(index);
                    });
                    Scaffold.of(context).showSnackBar(
                        SnackBar(content: Text("$item dismissed")));
                  },
                  background: Container(color: Colors.red),
                  child: ListTile(
                    title: Text('$item'),
                  ));
            }),
      ),
    );
  }
}
