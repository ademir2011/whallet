import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:whallet/src/portifolio/datasources/coingecko_datasource.dart';
import 'package:whallet/src/portifolio/datasources/pancakeswap_datasource.dart';
import 'package:whallet/src/portifolio/models/token_model.dart';

class TokenRepository {
  final FirebaseFirestore firebaseFirestore;
  final CoingeckoDatasource coingeckoDatasource;
  final PancakeswapDatasource pancakeswapDatasource;
  final Dio dio;

  TokenRepository({
    required this.firebaseFirestore,
    required this.coingeckoDatasource,
    required this.pancakeswapDatasource,
    required this.dio,
  });

  Future<TokenModel?> getTokenByInfo({required TokenModel tokenModel}) async {
    if (tokenModel.symbol != null) {
      TokenModel? tokenModelResult = await coingeckoDatasource.getTokenBySymbol(tokenModel: tokenModel);
      tokenModelResult!.updatedAtTokenValue = DateTime.now();
      return tokenModelResult;
    } else if (tokenModel.address != null) {
      return await pancakeswapDatasource.getTokenByAddress(tokenModel: tokenModel);
    }
    return Future.error(Exception);
  }

  Future<List<TokenModel>> getTokensByInfo({required TokenModel tokenModel}) async {
    if (tokenModel.symbol != null) {
      return await coingeckoDatasource.getTokensBySymbol(tokenModel: tokenModel);
    }
    return Future.error(Exception);
  }

  Future<void> saveToken({required TokenModel tokenModel}) async {
    CollectionReference tokensCollection = firebaseFirestore.collection('tokens');
    if (FirebaseAuth.instance.currentUser != null) {
      tokenModel.userId = FirebaseAuth.instance.currentUser!.uid;
      await tokensCollection.add(tokenModel.toMap());
    } else {
      throw Exception('Usuário não autenticado');
    }
  }

  Future<List> getLast24TokenPrices({required TokenModel tokenModel}) async {
    if (tokenModel.updatedAtTokenValue == null) throw Exception('Valor inválido');
    try {
      final beforeDate = tokenModel.updatedAtTokenValue!.subtract(const Duration(days: 1));
      final startDateString = beforeDate.millisecondsSinceEpoch.toString();
      final finalDateString = beforeDate.add(const Duration(hours: 1)).millisecondsSinceEpoch.toString();
      final startDateMs = startDateString.substring(0, startDateString.toString().length - 3);
      final endDateMs = finalDateString.substring(0, finalDateString.toString().length - 3);

      final response = await dio.get(
        'https://api.coingecko.com/api/v3/coins/${tokenModel.tokenId}/market_chart/range?vs_currency=usd&from=$startDateMs&to=$endDateMs',
      );
      return (response.data as Map<String, dynamic>)['prices'] as List;
    } catch (e) {
      throw Exception('erro');
    }
  }

  Future<double> getMean24TokenPrice({required TokenModel tokenModel}) async {
    final prices = await getLast24TokenPrices(tokenModel: tokenModel);
    final price = prices.map((e) => e[1] as double).reduce((value, element) => value + element) / prices.length;
    return price;
  }

  Future<List<double>> getLastHourPrices({required TokenModel tokenModel}) async {
    try {
      final startDateNow = DateTime.now().subtract(const Duration(hours: 1)).millisecondsSinceEpoch.toString();
      final endDateNow = DateTime.now().millisecondsSinceEpoch.toString();
      final startFormatedDate = startDateNow.substring(0, startDateNow.toString().length - 3);
      final endFormatedDate = endDateNow.substring(0, endDateNow.toString().length - 3);
      final response = await dio.get(
        'https://api.coingecko.com/api/v3/coins/${tokenModel.tokenId}/market_chart/range?vs_currency=usd&from=$startFormatedDate&to=$endFormatedDate',
      );
      List prices = (response.data as Map<String, dynamic>)['prices'] as List;
      return prices.map((e) => double.parse(e[1].toString())).toList();
    } catch (e) {
      throw Exception('error');
    }
  }

  Future<void> removeToken({required TokenModel tokenModel}) async {
    try {
      CollectionReference tokensCollection = FirebaseFirestore.instance.collection('tokens');
      QuerySnapshot qs = await tokensCollection
          .where(
            'userId',
            isEqualTo: FirebaseAuth.instance.currentUser!.uid,
          )
          .where('tokenId', isEqualTo: tokenModel.tokenId)
          .get();
      await tokensCollection.doc(qs.docs.first.id).delete();
    } catch (e) {
      throw Exception('Erro');
    }
  }
}
