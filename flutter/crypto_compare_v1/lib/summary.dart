import 'package:crypto_compare_v1/model/cointypes.dart';
import 'package:flutter/material.dart';

class SummaryScreen extends StatefulWidget {
  @override
  _SummaryScreenState createState() => _SummaryScreenState();
}

Widget _buildCoinPicker(String coin, List<Coins> coins) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      DropdownButton(
        value: coin,
        items: _buildCoinPickerMenuItems(coins),
        onChanged: (value) {
          print("Selected Value $value");
        },
      )
    ],
  );
}

List<DropdownMenuItem> _buildCoinPickerMenuItems(List<Coins> coins) {
  List<DropdownMenuItem> _coins = coins
      .map((c) => DropdownMenuItem(
            child: Text(c.toString().substring(c.toString().indexOf('.') + 1)),
          ))
      .toList();
  return _coins;
}

Widget _buildListView(BuildContext context) {
  return Expanded(
    child: Container(
      width: 250.0,
      height: 250.0,
      color: Colors.blue,
    ),
  );
}

class _SummaryScreenState extends State<SummaryScreen> {
  String _selectedCoin;
  List<Coins> _coins = List<Coins>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _coins = Coins.values;
    String _first = _coins.elementAt(0).toString();
    _selectedCoin = _first.substring(_first.indexOf('.') + 1);

    print("selected = $_selectedCoin");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Crypto Compare'),
        ),
        body: _buildCoinPicker(_selectedCoin, _coins));
  }
}
