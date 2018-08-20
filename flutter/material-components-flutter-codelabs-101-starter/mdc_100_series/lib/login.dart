import 'package:flutter/material.dart';
import 'colors.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // TODO: Add text editing controllers (101)
  final TextEditingController _tecu = TextEditingController();
  final TextEditingController _tecp = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            SizedBox(height: 80.0),
            Column(
              children: <Widget>[
                Image.asset('assets/diamond.png'),
                SizedBox(height: 16.0),
                Text('SHRINE'),
              ],
            ),
            SizedBox(height: 120.0),
            PrimaryColorOverride(
              color: kShrineBrown900,
              child: TextField(
                decoration: InputDecoration(labelText: "Username"),
                controller: _tecu,
              ),
            ),
            SizedBox(height: 12.0),
            PrimaryColorOverride(
              color: kShrineBrown900,
              child: TextField(
                decoration: InputDecoration(labelText: "Password"),
                obscureText: true,
                controller: _tecp,
              ),
            ),
            SizedBox(height: 12.0),
            ButtonBar(
              children: <Widget>[
                FlatButton(
                  shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(7.0))),
                  child: Text("CANCEL"),
                  onPressed: () {
                    _tecp.clear();
                    _tecu.clear();
                  },
                ),
                RaisedButton(
                  elevation: 8.0,
                  shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(7.0))),
                  child: Text("NEXT"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            )
            // TODO: Wrap Username with PrimaryColorOverride (103)
            // TODO: Remove filled: true values (103)
            // TODO: Wrap Password with PrimaryColorOverride (103)
          ],
        ),
      ),
    );
  }
}

class PrimaryColorOverride extends StatelessWidget {
  const PrimaryColorOverride({Key key, this.color, this.child})
      : super(key: key);

  final Color color;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Theme(
      child: child,
      data: Theme.of(context).copyWith(primaryColor: color),
    );
  }
}
