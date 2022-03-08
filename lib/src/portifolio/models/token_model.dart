import 'dart:convert';

class TokenModel {
  final String? name;
  final String? docRef;
  final String? userId;
  final String? tokenId;
  final String? symbol;
  final double? quantity;
  final DateTime? dateAcquisition;
  final DateTime? updatedAtTokenValue;
  final double? usdPrice;
  final String? address;

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
  }) : assert(address == null || RegExp(r'0x\w+').hasMatch(address), 'Endereço inválido');

  factory TokenModel.address({required String address}) => TokenModel(
        address: address,
      );

  factory TokenModel.symbol({required String symbol}) => TokenModel(
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
    );
  }

  String toJson() => json.encode(toMap());

  factory TokenModel.fromJson(String source) => TokenModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TokenModel(name: $name, docRef: $docRef, userId: $userId, tokenId: $tokenId, symbol: $symbol, quantity: $quantity, dateAcquisition: $dateAcquisition, updatedAtTokenValue: $updatedAtTokenValue, usdPrice: $usdPrice, address: $address)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TokenModel &&
        other.name == name &&
        other.docRef == docRef &&
        other.userId == userId &&
        other.tokenId == tokenId &&
        other.symbol == symbol &&
        other.quantity == quantity &&
        other.dateAcquisition == dateAcquisition &&
        other.updatedAtTokenValue == updatedAtTokenValue &&
        other.usdPrice == usdPrice &&
        other.address == address;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        docRef.hashCode ^
        userId.hashCode ^
        tokenId.hashCode ^
        symbol.hashCode ^
        quantity.hashCode ^
        dateAcquisition.hashCode ^
        updatedAtTokenValue.hashCode ^
        usdPrice.hashCode ^
        address.hashCode;
  }
}
