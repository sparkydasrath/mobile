import 'dart:async';

import 'package:crypto_compare_v2/model/coin.dart';
import 'package:crypto_compare_v2/model/common_fields.dart';
import 'package:crypto_compare_v2/model/currency.dart';
import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class CryptoBloc {
  Future<Map<String, Object>> getFullDislaySymbols(String url) async {
    http.Response response = await http.get(url);

    Map<String, Object> displayPart;
    if (response.statusCode == 200) {
      Map<String, Object> decoded = json.decode(response.body);
      displayPart = decoded["DISPLAY"];
    }
    return displayPart;
  }

  Map<String, Object> getFullDislaySymbolsLocal(String url) {
    File file = File('./test/full_coin.json');
    Map<String, Object> result =
        json.decode(file.readAsStringSync())["DISPLAY"];
    return result;
  }

  List<Coin> getCoinsFromDisplaySymbols(Map<String, Object> displayObject) {
    List<Coin> _coins = <Coin>[];
    List<Currency> _currencies = <Currency>[];
    Iterable<String> coinKeys = displayObject.keys;

    coinKeys.forEach((c) {
      _currencies = _extractCurrencies(c, displayObject[c]);
      Coin coin = Coin(c, _currencies);
      _coins.add(coin);
      coin.printCoin();
    });

    return _coins;
  }

  List<Currency> _extractCurrencies(
      String coin, Map<String, Object> currencyObject) {
    List<Currency> currencies = <Currency>[];
    Iterable<String> currencyKeys = currencyObject.keys;

    currencyKeys.forEach((c) {
      CommonFields cf = CommonFields(currencyObject[c]);
      Currency curr = Currency(coin, c, cf);
      currencies.add(curr);
    });

    return currencies;
  }
}
