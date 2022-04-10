abstract class AuthState {}

class AuthInitialState extends AuthState {}

class ErrorAuthState extends AuthState {
  final String message;
  ErrorAuthState({required this.message});
}

class LoadingAuthState extends AuthState {}

class LoadingCheckCredentialAuthState extends AuthState {}

class SuccessAuthState extends AuthState {
  SuccessAuthState();
}

class SuccessCredentialAuthState extends AuthState {
  String email;
  String password;
  bool checkDataCredential;

  SuccessCredentialAuthState({this.checkDataCredential = false, this.email = '', this.password = ''});
}
