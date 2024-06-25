abstract class AuthStates {}

final class InitialAuthState extends AuthStates {}

final class SignUpGoogleSuccess extends AuthStates {}

final class SignUpGoogleError extends AuthStates {
  final String error;
  SignUpGoogleError(this.error);
}
