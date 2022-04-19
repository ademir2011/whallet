import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:whallet/src/portifolio/external/datasources/coingecko_fetch_tokens_datasource.dart';

class TokenRepository {
  // Future<List> getLast24TokenPrices({required TokenModel tokenModel}) async {
  //   if (tokenModel.updatedAtTokenValue == null) throw Exception('Valor inválido');
  //   try {
  //     final beforeDate = tokenModel.updatedAtTokenValue!.subtract(const Duration(days: 1));
  //     final startDateString = beforeDate.millisecondsSinceEpoch.toString();
  //     final finalDateString = beforeDate.add(const Duration(hours: 1)).millisecondsSinceEpoch.toString();
  //     final startDateMs = startDateString.substring(0, startDateString.toString().length - 3);
  //     final endDateMs = finalDateString.substring(0, finalDateString.toString().length - 3);

  //     final response = await dio.get(
  //       'https://api.coingecko.com/api/v3/coins/${tokenModel.tokenId}/market_chart/range?vs_currency=usd&from=$startDateMs&to=$endDateMs',
  //     );
  //     return (response.data as Map<String, dynamic>)['prices'] as List;
  //   } catch (e) {
  //     throw Exception('erro');
  //   }
  // }

  // Future<double> getMean24TokenPrice({required TokenModel tokenModel}) async {
  //   final prices = await getLast24TokenPrices(tokenModel: tokenModel);
  //   final price = prices.map((e) => e[1] as double).reduce((value, element) => value + element) / prices.length;
  //   return price;
  // }

  // Future<List<double>> getLastHourPrices({required TokenModel tokenModel}) async {
  //   try {
  //     final startDateNow = DateTime.now().subtract(const Duration(hours: 1)).millisecondsSinceEpoch.toString();
  //     final endDateNow = DateTime.now().millisecondsSinceEpoch.toString();
  //     final startFormatedDate = startDateNow.substring(0, startDateNow.toString().length - 3);
  //     final endFormatedDate = endDateNow.substring(0, endDateNow.toString().length - 3);
  //     final response = await dio.get(
  //       'https://api.coingecko.com/api/v3/coins/${tokenModel.tokenId}/market_chart/range?vs_currency=usd&from=$startFormatedDate&to=$endFormatedDate',
  //     );
  //     List prices = (response.data as Map<String, dynamic>)['prices'] as List;
  //     return prices.map((e) => double.parse(e[1].toString())).toList();
  //   } catch (e) {
  //     throw Exception('error');
  //   }
  // }
}
