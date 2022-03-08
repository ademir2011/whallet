import 'dart:convert';

class UserModel {
  final String login;
  final String password;
  final String email;
  final String uid;
  final String docRef;
  UserModel({
    required this.login,
    required this.password,
    required this.email,
    required this.uid,
    required this.docRef,
  })  : assert(password.length >= 6, 'Senha muito pequena.'),
        assert(login.length >= 6 && login.length < 50, 'Login muito pequeno ou grande.'),
        assert(email.contains(RegExp(r'[a-zA-Z0-9._-]+@[a-zA-Z0-9._-]+')), 'E-mail diferente.');

  UserModel copyWith({
    String? login,
    String? password,
    String? email,
    String? uid,
    String? docRef,
  }) {
    return UserModel(
      login: login ?? this.login,
      password: password ?? this.password,
      email: email ?? this.email,
      uid: uid ?? this.uid,
      docRef: docRef ?? this.docRef,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'login': login,
      'password': password,
      'email': email,
      'uid': uid,
      'docRef': docRef,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      login: map['login'] ?? '',
      password: map['password'] ?? '',
      email: map['email'] ?? '',
      uid: map['uid'] ?? '',
      docRef: map['docRef'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(login: $login, password: $password, email: $email, uid: $uid, docRef: $docRef)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.login == login &&
        other.password == password &&
        other.email == email &&
        other.uid == uid &&
        other.docRef == docRef;
  }

  @override
  int get hashCode {
    return login.hashCode ^ password.hashCode ^ email.hashCode ^ uid.hashCode ^ docRef.hashCode;
  }
}
