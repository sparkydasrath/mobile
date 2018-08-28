import 'dart:collection';
import 'package:crypto_compare_v2/blocs/crypto_bloc.dart';
import 'package:crypto_compare_v2/model/coin.dart';
import 'package:crypto_compare_v2/model/currency.dart';
import 'package:flutter/material.dart';

void main() {
  final cryptoBloc = CryptoBloc();
  runApp(new MyApp(cryptoBloc));
}

class MyApp extends StatelessWidget {
  final CryptoBloc cryptoBloc;
  MyApp(this.cryptoBloc);

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Crypto Compare',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new CryptoLandingPage(
        title: 'Crypto Compare',
        cryptoBlock: this.cryptoBloc,
      ),
    );
  }
}

class CryptoLandingPage extends StatefulWidget {
  final CryptoBloc cryptoBlock;
  final String title;

  CryptoLandingPage({Key key, this.title, this.cryptoBlock}) : super(key: key);

  @override
  _CryptoLandingPageState createState() => new _CryptoLandingPageState();
}

class _CryptoLandingPageState extends State<CryptoLandingPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: StreamBuilder<UnmodifiableListView<Coin>>(
        stream: widget.cryptoBlock.coins,
        initialData: UnmodifiableListView<Coin>([]),
        builder: (context, snapshot) => ListView(
              children: snapshot.data.map(_buildCoin).toList(),
            ),
      ),
    );
  }

  Widget _buildCoin(Coin coin) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: ExpansionTile(
        title: Text(
          coin.coin,
          style: Theme.of(context).textTheme.title,
        ),
        children: <Widget>[
          ListView(
            children: coin.currencies.map(_buildCurrency).toList(),
            shrinkWrap: true,
          ),
        ],
      ),
    );
  }

  Widget _buildCurrency(Currency c) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[Text(c.currency), Text(c.commonFields.price)],
      ),
    );
  }
}
