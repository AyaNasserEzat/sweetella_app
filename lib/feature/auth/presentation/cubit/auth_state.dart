abstract class AuthState {}

class AuthInitial extends AuthState {}

class SignInLoading extends AuthState {}

class SignInSuccess extends AuthState {}

class SignInError extends AuthState {
  final String message;
  SignInError(this.message);
}

class SignUpLoading extends AuthState {}

class SignUpSuccess extends AuthState {}

class SignUpError extends AuthState {
  final String message;
  SignUpError(this.message);
}

class ForgetPasswordLoading extends AuthState {}

class ForgetPasswordSuccess extends AuthState {}

class ForgetPasswordError extends AuthState {
  final String message;
  ForgetPasswordError(this.message);
}

class AuthAuthenticated extends AuthState {}

class AuthUnauthenticated extends AuthState {}