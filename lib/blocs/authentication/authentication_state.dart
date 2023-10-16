part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object?> get props => [];
}

class AuthenticationInitial extends AuthenticationState {
  @override
  List<Object?> get props => [];
}

class AuthenticationLoading extends AuthenticationState {
  @override
  List<Object?> get props => [];
}

class AuthenticationSuccess extends AuthenticationState {
  final String email;

  const AuthenticationSuccess({required this.email});

  @override
  List<Object?> get props => [email];
}

class AuthenticationNone extends AuthenticationState {
  @override
  List<Object?> get props => [];
}

class AuthenticationError extends AuthenticationState {
  final String message;

  const AuthenticationError({required this.message});

  @override
  List<Object?> get props => [message];
}
