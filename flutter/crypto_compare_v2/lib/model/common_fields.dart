class CommonFields {
  final Map values;
  CommonFields(this.values);

  String get typeOfItem => values["TYPE"];
  String get market => values["MARKET"];
  String get fromSymbol => values["FROMSYMBOL"];
  String get toSymbol => values["TOSYMBOL"];
  String get flags => values["FLAGS"];
  String get price => values["PRICE"];
  String get lastUpdate => values["LASTUPDATE"];
  String get lastVolume => values["LASTVOLUME"];
  String get lastVolumeTo => values["LASTVOLUMETO"];
  String get lastTradeId => values["LASTTRADEID"];
  String get volumeDay => values["VOLUMEDAY"];
  String get volumenDayTo => values["VOLUMEDAYTO"];
  String get volume24Hour => values["VOLUME24HOUR"];
  String get volume24HourTo => values["VOLUME24HOURTO"];
  String get openDay => values["OPENDAY"];
  String get highDay => values["HIGHDAY"];
  String get lowDay => values["LOWDAY"];
  String get open24Hour => values["OPEN24HOUR"];
  String get high24Hour => values["HIGH24HOUR"];
  String get low24Hour => values["LOW24HOUR"];
  String get lastMarket => values["LASTMARKET"];
  String get change24Hour => values["CHANGE24HOUR"];
  String get changePct24Hour => values["CHANGEPCT24HOUR"];
  String get changeDay => values["CHANGEDAY"];
  String get changePctDay => values["CHANGEPCTDAY"];
  String get supply => values["SUPPLY"];
  String get marketCap => values["MKTCAP"];
  String get totalVolume24Hour => values["TOTALVOLUME24H"];
  String get totalVolume24HourTo => values["TOTALVOLUME24HTO"];

  @override
  String toString() => values.toString();
}
