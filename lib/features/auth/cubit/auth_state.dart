part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthLoggedIn extends AuthState {}

class AuthRegistered extends AuthState {}

class AuthLoggedOut extends AuthState {}

class AuthError extends AuthState {
  final Failure error;
  AuthError(this.error);
}
