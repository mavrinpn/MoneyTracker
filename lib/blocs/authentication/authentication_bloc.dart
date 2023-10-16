import 'package:diploma/core/helpers.dart';
import 'package:module_business/module_business.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserSignIn userSignIn;
  final UserSignUp userSignUp;
  final UserSignOut userSignOut;
  final UserUid userUid;
  final UserEmail userEmail;

  AuthenticationBloc({
    required this.userSignIn,
    required this.userSignUp,
    required this.userSignOut,
    required this.userUid,
    required this.userEmail,
  }) : super(AuthenticationInitial()) {
    on<AuthenticationStarted>((event, emit) async {
      String userId = userUid();
      if (userId != '') {
        String email = userEmail();
        emit(AuthenticationSuccess(email: email));
      } else {
        emit(AuthenticationNone());
      }
    });

    on<AuthenticationSignIn>((event, emit) async {
      emit(AuthenticationLoading());
      final failureOrUserSingIn = await userSignIn(
        email: event.email,
        password: event.password,
      );
      failureOrUserSingIn.fold((failure) {
        emit(AuthenticationError(message: mapFailureToMessage(failure)));
      }, (_) {
        String email = userEmail();
        emit(AuthenticationSuccess(email: email));
      });
    });

    on<AuthenticationSignUp>((event, emit) async {
      emit(AuthenticationLoading());
      final failureOrUserSingUp = await userSignUp(
        email: event.email,
        password: event.password,
      );
      failureOrUserSingUp.fold((failure) {
        emit(AuthenticationError(message: mapFailureToMessage(failure)));
      }, (_) {
        String email = userEmail();
        emit(AuthenticationSuccess(email: email));
      });
    });

    on<AuthenticationSignOut>((event, emit) async {
      await userSignOut();
      emit(AuthenticationNone());
    });
  }
}
