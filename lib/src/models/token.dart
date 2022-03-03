import 'dart:convert';

class Token {
  final String name;
  final String symbol;
  final double usdPrice;
  final String address;
  Token({
    required this.name,
    required this.symbol,
    required this.usdPrice,
    required this.address,
  });

  Token copyWith({
    String? name,
    String? symbol,
    double? usdPrice,
    String? address,
  }) {
    return Token(
      name: name ?? this.name,
      symbol: symbol ?? this.symbol,
      usdPrice: usdPrice ?? this.usdPrice,
      address: address ?? this.address,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'symbol': symbol,
      'usdPrice': usdPrice,
      'address': address,
    };
  }

  factory Token.address({required String address}) {
    return Token(name: '', symbol: '', usdPrice: 0.0, address: address);
  }

  factory Token.symbol({required String symbol}) {
    return Token(name: '', symbol: symbol, usdPrice: 0.0, address: '');
  }

  factory Token.fromMap(Map<String, dynamic> map) {
    return Token(
      name: map['name'] ?? '',
      symbol: map['symbol'] ?? '',
      usdPrice: map['usdPrice']?.toDouble() ?? 0.0,
      address: map['address'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Token.fromJson(String source) => Token.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Token(name: $name, symbol: $symbol, usdPrice: $usdPrice, address: $address)';
  }
}
