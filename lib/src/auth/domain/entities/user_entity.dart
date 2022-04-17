import 'dart:convert';

class UserEntity {
  final String password;
  final String email;
  final String uid;
  final String docRef;
  UserEntity({
    required this.password,
    required this.email,
    required this.uid,
    required this.docRef,
  });
}
