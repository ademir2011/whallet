abstract class AuthEvent {}

class AuthSignInEvent extends AuthEvent {
  final String email;
  final String password;

  AuthSignInEvent({required this.email, required this.password});
}

class CheckDataCredentialEvent extends AuthEvent {}

class AuthRemoveCredentialEvent extends AuthEvent {}

class AuthSaveCredentialEvent extends AuthEvent {
  final String email;
  final String password;
  AuthSaveCredentialEvent({required this.email, required this.password});
}

class AuthSignUpEvent extends AuthEvent {
  final String email;
  final String password;
  final String confirmPassword;

  AuthSignUpEvent({required this.email, required this.password, required this.confirmPassword});
}

class AuthSignOutEvent extends AuthEvent {}
