import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => MainScreen(),
        '/second': (context) => SecondScreen()
      },
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Screen'),
      ),
      body: Center(
          child: RaisedButton(
        child: Text("go to second screen"),
        onPressed: () {
          Navigator.pushNamed(context, '/second');
        },
      )),
    );
    ;
  }
}

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Screen'),
      ),
      body: Center(
        child: RaisedButton(
          child: Text("return home"),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
    ;
  }
}
