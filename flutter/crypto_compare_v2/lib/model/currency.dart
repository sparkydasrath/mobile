import 'package:crypto_compare_v2/model/common_fields.dart';

class Currency {
  final String currency;
  final CommonFields commonFields;
  final String coin;
  Currency(this.coin, this.currency, this.commonFields);

  String get key => coin + '-' + currency;

  @override
  String toString() => this.currency + '\n' + commonFields.toString();
}
