class SingleSymbolPrice {
  final double price;
  final String currency;

  SingleSymbolPrice(this.currency, this.price);

  SingleSymbolPrice.fromJson(this.currency, Map<String, dynamic> json)
      : price = json[currency];

  @override
  String toString() {
    return this.currency + ":" + this.price.toString();
  }
}
