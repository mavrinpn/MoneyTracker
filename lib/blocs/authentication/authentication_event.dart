part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AuthenticationStarted extends AuthenticationEvent {
  @override
  List<Object> get props => [];
}

class AuthenticationSignIn extends AuthenticationEvent {
  final String email;
  final String password;
  const AuthenticationSignIn({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class AuthenticationSignUp extends AuthenticationEvent {
  final String email;
  final String password;
  const AuthenticationSignUp({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class AuthenticationSignOut extends AuthenticationEvent {
  @override
  List<Object> get props => [];
}
