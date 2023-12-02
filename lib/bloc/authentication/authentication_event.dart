part of 'authentication_bloc.dart';

sealed class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

final class AuthenticationStarted extends AuthenticationEvent {}

final class AuthenticationLoggedIn extends AuthenticationEvent {
  final String username;
  final String password;
  final String provider;
  final String dbName;

  const AuthenticationLoggedIn(this.username, this.password, this.provider, this.dbName);

  @override
  List<Object> get props => [username, password, provider, dbName];
}

final class AuthenticationLoggedOut extends AuthenticationEvent {}
