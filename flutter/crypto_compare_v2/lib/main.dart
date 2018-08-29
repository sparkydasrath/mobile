import 'dart:collection';
import 'package:crypto_compare_v2/blocs/crypto_bloc.dart';
import 'package:crypto_compare_v2/model/coin.dart';
import 'package:crypto_compare_v2/model/currency.dart';
import 'package:crypto_compare_v2/model/logos.dart';
import 'package:flutter/material.dart';

void main() {
  final cryptoBloc = CryptoBloc();
  Logos(); // force intit logos to populate assets
  runApp(new MyApp(cryptoBloc));
}

const double rowPadding = 8.0;
const double volTitleSectionPadding = 10.0;
const double volColumnPadding = 6.0;

class MyApp extends StatelessWidget {
  final CryptoBloc cryptoBloc;
  MyApp(this.cryptoBloc);

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Crypto Snapshot',
      theme: ThemeData.dark(),
      home: new CryptoLandingPage(
        title: 'Crypto Snapshot',
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
      body: RefreshIndicator(
        onRefresh: widget.cryptoBlock.refresh,
        child: StreamBuilder<UnmodifiableListView<Coin>>(
          stream: widget.cryptoBlock.coins,
          initialData: UnmodifiableListView<Coin>([]),
          builder: (context, snapshot) => ListView(
                children: snapshot.data.map(_buildCoinContainer).toList(),
              ),
        ),
      ),
    );
  }

  Widget _buildCoinContainer(Coin coin) {
    return Padding(
        padding: const EdgeInsets.all(2.0), child: _buildCoinExpander(coin));
  }

  Widget _buildCoinExpander(Coin coin) {
    return ExpansionTile(
      title: Row(
        children: <Widget>[
          SizedBox(
            height: 40.0,
            child: Image.asset(Logos.getAssetPathFromKey(coin.coin)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              coin.coin,
              style: TextStyle(fontSize: 40.0),
            ),
          ),
        ],
      ),
      children: <Widget>[
        ListView(
          physics: ClampingScrollPhysics(),
          children: coin.currencies.map(_buildCurrency).toList(),
          shrinkWrap: true,
        ),
      ],
    );
  }

  Widget _buildCurrency(Currency c) {
    return Card(
      elevation: 1.0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: rowPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            _buildPriceRow(c),
            Divider(),
            _buildDayAnd24HrSection(c),
            Divider(),
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: _buildVolumeSection(c),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPriceRow(Currency c) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          c.commonFields.price,
          style: Theme.of(context).textTheme.display1,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Icon(
              Icons.arrow_drop_up,
              color: Colors.red,
              size: 40.0,
            ),
            Text(
              c.commonFields.changePct24Hour + " %",
              style: TextStyle(fontSize: 20.0),
            )
          ],
        )
      ],
    );
  }

  Widget _buildDayAnd24HrSection(Currency c) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(""),
            Text("DAY"),
            Text("24 HR"),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Text("OPEN"),
            Text(c.commonFields.openDay),
            Text(c.commonFields.open24Hour),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Text("LOW"),
            Text(c.commonFields.lowDay),
            Text(c.commonFields.low24Hour),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Text("HIGH"),
            Text(c.commonFields.highDay),
            Text(c.commonFields.high24Hour),
          ],
        ),
      ],
    );
  }

  Widget _buildVolumeSection(Currency c) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Text("VOLUME"),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text("DAY"),
                  Text(c.commonFields.volumeDay),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text("LAST"),
                  Text(c.commonFields.lastVolume),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text("24 HR"),
                  Text(c.commonFields.volume24Hour),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text("TOTAL 24 HR"),
                  Text(c.commonFields.totalVolume24Hour),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
