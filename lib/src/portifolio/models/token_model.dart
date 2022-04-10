import 'dart:convert';

class TokenModel {
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

  TokenModel({
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
  });
  // : assert(address == null || RegExp(r'0x\w+').hasMatch(address), 'Endereço inválido');

  factory TokenModel.address({required String address}) => TokenModel().copyWith(
        address: address,
      );

  factory TokenModel.symbol({required String symbol}) => TokenModel().copyWith(
        symbol: symbol,
      );

  TokenModel copyWith({
    String? name,
    String? docRef,
    String? userId,
    String? tokenId,
    String? symbol,
    double? quantity,
    DateTime? dateAcquisition,
    DateTime? updatedAtTokenValue,
    double? usdPrice,
    String? address,
    double? last24price,
  }) {
    return TokenModel(
      name: name ?? this.name,
      docRef: docRef ?? this.docRef,
      userId: userId ?? this.userId,
      tokenId: tokenId ?? this.tokenId,
      symbol: symbol ?? this.symbol,
      quantity: quantity ?? this.quantity,
      dateAcquisition: dateAcquisition ?? this.dateAcquisition,
      updatedAtTokenValue: updatedAtTokenValue ?? this.updatedAtTokenValue,
      usdPrice: usdPrice ?? this.usdPrice,
      address: address ?? this.address,
      last24price: last24price ?? this.last24price,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'docRef': docRef,
      'userId': userId,
      'tokenId': tokenId,
      'symbol': symbol,
      'quantity': quantity,
      'dateAcquisition': dateAcquisition?.millisecondsSinceEpoch,
      'updatedAtTokenValue': updatedAtTokenValue?.millisecondsSinceEpoch,
      'usdPrice': usdPrice,
      'address': address,
      'last24price': last24price,
    };
  }

  factory TokenModel.fromMap(Map<String, dynamic> map) {
    return TokenModel(
      name: map['name'],
      docRef: map['docRef'],
      userId: map['userId'],
      tokenId: map['tokenId'],
      symbol: map['symbol'],
      quantity: map['quantity']?.toDouble(),
      dateAcquisition:
          map['dateAcquisition'] != null ? DateTime.fromMillisecondsSinceEpoch(map['dateAcquisition']) : null,
      updatedAtTokenValue:
          map['updatedAtTokenValue'] != null ? DateTime.fromMillisecondsSinceEpoch(map['updatedAtTokenValue']) : null,
      usdPrice: map['usdPrice']?.toDouble(),
      address: map['address'],
      last24price: map['last24price'],
    );
  }

  String toJson() => json.encode(toMap());

  factory TokenModel.fromJson(String source) => TokenModel.fromMap(json.decode(source));
}
