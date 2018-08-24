import 'dart:async';
import 'dart:convert';
import 'package:crypto_compare_v1/model/singlesymbolprice.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SummaryScreen extends StatefulWidget {
  @override
  _SummaryScreenState createState() => _SummaryScreenState();
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
  String _selectedCurrency;
  List<String> _coins = List<String>();
  List<String> _currencies = List<String>();
  String _url;
  SingleSymbolPrice _singleSymbolPrice;

  _SummaryScreenState() : super() {
    print("constructor called");
  }

  String _createUrl(String coin, String currency) {
    return "https://min-api.cryptocompare.com/data/price?fsym=$coin&tsyms=$currency";
  }

  @override
  void initState() {
    super.initState();
    _coins = ["BTC", "ETH"];
    _currencies = ["USD", "EUR", "GBP", "JPY"];
    _selectedCoin = _coins.first;
    _selectedCurrency = _currencies.first;
    _url = _createUrl(_selectedCoin, _selectedCurrency);
    _fetchPrices(_url);
    print("initState done");
  }

  void _handleCurrencyChanged(value) {
    setState(() {
      _selectedCurrency = value;
      _url = _createUrl(_selectedCoin, value);
      _fetchPrices(_url);
    });
  }

  void _handleCoinChanged(value) {
    _selectedCoin = value;
    _url = _createUrl(value, _selectedCurrency);
    _fetchPrices(_url);
  }

  Future<String> _fetchPrices(String url) async {
    try {
      http.Response response = await http
          .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
      print(response.body);

      setState(() {
        var decoded = json.decode(response.body);
        _singleSymbolPrice =
            new SingleSymbolPrice.fromJson(_selectedCurrency, decoded);
      });

      return "SUCCESS";
    } catch (e) {
      print("error getting data $e");
      return "Failed";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crypto Compare'),
      ),
      body: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              DropdownButton(
                value: _selectedCoin,
                items: _coins.map((String c) {
                  return new DropdownMenuItem(
                    value: c,
                    child: Text(c),
                  );
                }).toList(),
                onChanged: (value) {
                  print('coin is $value');
                  _handleCoinChanged(value);
                },
              ),
              DropdownButton(
                value: _selectedCurrency,
                items: _currencies.map((String c) {
                  return new DropdownMenuItem(
                    value: c,
                    child: Text(c),
                  );
                }).toList(),
                onChanged: (value) {
                  print('currency is $value');
                  _handleCurrencyChanged(value);
                },
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Text(_singleSymbolPrice.currency),
              Text(_singleSymbolPrice.price.toString()),
            ],
          )
        ],
      ),
    );
  }
}
