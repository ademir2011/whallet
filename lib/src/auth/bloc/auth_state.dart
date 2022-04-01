import 'package:flutter/material.dart';
import 'package:whallet/src/auth/models/user_model.dart';

abstract class AuthState {}

class AuthInitialState extends AuthState {
  final UserModel userModel;
  AuthInitialState({required this.userModel});
}

class ErrorAuthState extends AuthState {}

class LoadingAuthState extends AuthState {}

class SucessAuthState extends AuthState {}
