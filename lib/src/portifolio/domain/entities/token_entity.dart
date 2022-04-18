class TokenEntity {
  String? name;
  String? docRef;
  String? userId;
  String? tokenId;
  String? symbol;
  double? quantity;
  DateTime? dateAcquisition;
  DateTime? updatedAtTokenValue;
  double? usdPrice;
  String? address;
  double? last24price;
  List<double>? lastHourPrices;

  TokenEntity({
    this.name,
    this.docRef,
    this.userId,
    this.tokenId,
    this.symbol,
    this.quantity,
    this.dateAcquisition,
    this.updatedAtTokenValue,
    this.usdPrice,
    this.address,
    this.last24price,
    this.lastHourPrices,
  });
}
