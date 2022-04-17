import 'dart:convert';

import 'package:whallet/src/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  final String password;
  final String email;
  final String uid;
  final String docRef;

  UserModel({required this.password, required this.email, required this.uid, required this.docRef})
      : super(password: password, email: email, uid: uid, docRef: docRef);

  factory UserModel.empty() => UserModel(password: '', email: '', uid: '', docRef: '');

  UserModel copyWith({
    String? password,
    String? email,
    String? uid,
    String? docRef,
  }) {
    return UserModel(
      password: password ?? this.password,
      email: email ?? this.email,
      uid: uid ?? this.uid,
      docRef: docRef ?? this.docRef,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'password': password,
      'email': email,
      'uid': uid,
      'docRef': docRef,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      password: map['password'] ?? '',
      email: map['email'] ?? '',
      uid: map['uid'] ?? '',
      docRef: map['docRef'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source));
}
