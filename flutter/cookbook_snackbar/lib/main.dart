import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Snackbar Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('snackbar demo'),
        ),
        body: SnackBarPage(),
      ),
    );
  }
}

class SnackBarPage extends StatelessWidget {
  final sba = SnackBarAction(
    label: "Undo",
    onPressed: () {},
  );

  void _handleButtonPressed(BuildContext context) {
    final snackbar =
        SnackBar(content: Text('my first snack'), action: this.sba);

    Scaffold.of(context).showSnackBar(snackbar);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: RaisedButton(
      child: Text("show sb"),
      onPressed: () => this._handleButtonPressed(context),
    ));
  }
}
