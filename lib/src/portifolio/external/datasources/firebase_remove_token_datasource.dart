import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:whallet/src/portifolio/domain/entities/token_entity.dart';
import 'package:whallet/src/portifolio/infra/datasources/remove_token_datasource_interface.dart';

class FirebaseRemoveTokenDatasource implements IRemoveTokenDatasource {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseAuth firebaseAuth;

  FirebaseRemoveTokenDatasource({
    required this.firebaseFirestore,
    required this.firebaseAuth,
  });

  @override
  Future<void> removeToken({required TokenEntity tokenEntity}) async {
    try {
      CollectionReference tokensCollection = firebaseFirestore.collection('tokens');
      QuerySnapshot qs = await tokensCollection
          .where(
            'userId',
            isEqualTo: firebaseAuth.currentUser!.uid,
          )
          .where('tokenId', isEqualTo: tokenEntity.tokenId)
          .get();
      await tokensCollection.doc(qs.docs.first.id).delete();
    } catch (e) {
      throw Exception('Erro');
    }
  }
}
