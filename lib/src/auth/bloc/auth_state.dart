abstract class AuthState {}

class AuthInitialState extends AuthState {}

class ErrorAuthState extends AuthState {
  final String message;
  ErrorAuthState({required this.message});
}

class LoadingAuthState extends AuthState {}

class SuccessAuthState extends AuthState {}
