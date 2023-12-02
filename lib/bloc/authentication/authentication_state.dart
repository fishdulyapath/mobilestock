part of 'authentication_bloc.dart';

sealed class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

final class AuthenticationInitial extends AuthenticationState {}

final class AuthenticationSuccess extends AuthenticationState {
  final String username;

  const AuthenticationSuccess(this.username);

  @override
  List<Object> get props => [username];
}

final class AuthenticationFailure extends AuthenticationState {}

final class AuthenticationInProgress extends AuthenticationState {}

final class AuthenticationLogout extends AuthenticationState {}

final class AuthenticationError extends AuthenticationState {
  final String message;

  const AuthenticationError(this.message);

  @override
  List<Object> get props => [message];
}
