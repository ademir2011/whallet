import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:whallet/src/portifolio/domain/entities/token_entity.dart';
import 'package:whallet/src/portifolio/infra/datasources/create_token_datasource_interface.dart';

class FirebaseCreateTokenDatasource implements ICreateTokenDatasource {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseAuth firebaseAuth;

  FirebaseCreateTokenDatasource({
    required this.firebaseFirestore,
    required this.firebaseAuth,
  });

  @override
  Future<void> createToken({required TokenEntity tokenEntity}) async {
    CollectionReference tokensCollection = firebaseFirestore.collection('tokens');
    if (firebaseAuth.currentUser != null) {
      tokenEntity.userId = firebaseAuth.currentUser!.uid;
      await tokensCollection.add(tokenEntity);
    } else {
      throw Exception('Usuário não autenticado');
    }
  }
}
