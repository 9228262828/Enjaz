

// Base Auth State
abstract class AuthState {}

class AuthInitial extends AuthState {}

// States for Registering
class RegisterLoading extends AuthState {}

class RegisterSuccess extends AuthState {}

class RegisterFailure extends AuthState {
  final String error;

  RegisterFailure(this.error);
}

// States for Logging in
class LoginLoading extends AuthState {}

class LoginSuccess extends AuthState {}

class LoginFailure extends AuthState {
  final String error;

  LoginFailure(this.error);
}
