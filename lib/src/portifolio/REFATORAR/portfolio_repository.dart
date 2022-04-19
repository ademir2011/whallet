import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PortfolioRepository {
  // FirebaseFirestore firebaseFirestore;
  // Dio dio;
  // TokenRepository tokenRepository;

  // PortfolioRepository({
  //   required this.firebaseFirestore,
  //   required this.dio,
  //   required this.tokenRepository,
  // });

  // Future<List<TokenModel>> getTokensByUser() async {
  //   CollectionReference tokensCollection = firebaseFirestore.collection('tokens');
  //   QuerySnapshot<Object?> querySnapshot = await tokensCollection
  //       .where(
  //         'userId',
  //         isEqualTo: FirebaseAuth.instance.currentUser!.uid,
  //       )
  //       .get();

  //   var tokens =
  //       querySnapshot.docs.map((element) => TokenModel.fromMap(element.data() as Map<String, dynamic>)).toList();

  //   await Future.wait(tokens.map((element) async {
  //     element.updatedAtTokenValue = DateTime.now();
  //     element.last24price = await tokenRepository.getMean24TokenPrice(tokenModel: element);
  //   }).toList());

  //   return getPriceByToken(tokensModel: tokens);
  // }

  // Future<List<TokenModel>> getPriceByToken({required List<TokenModel> tokensModel}) async {
  //   try {
  //     final query = tokensModel.map((e) => e.tokenId).toList().join(',');
  //     final response = await dio.get('https://api.coingecko.com/api/v3/simple/price?ids=$query&vs_currencies=usd');

  //     response.data!.entries.forEach((map) {
  //       tokensModel.where((token) => token.tokenId == map.key).first.usdPrice = double.tryParse(
  //             map.value['usd'].toString(),
  //           ) ??
  //           .0;
  //     });
  //     return tokensModel;
  //   } catch (e) {
  //     return throw Exception();
  //   }
  // }
}
