part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class RegisterInitial extends AuthState {}

final class RegisterLoading extends AuthState {}

final class RegisterSuccess extends AuthState {}

final class RegisterFailed extends AuthState {
  final String message;

  RegisterFailed({required this.message});
}

final class LoginLoading extends AuthState {}

final class LoginSuccess extends AuthState {}

final class LoginFailed extends AuthState {
  final String message;

  LoginFailed({required this.message});
}
