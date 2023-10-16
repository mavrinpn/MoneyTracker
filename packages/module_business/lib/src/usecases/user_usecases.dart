import 'package:dartz/dartz.dart';
import 'package:module_business/module_business.dart';

class UserUid {
  final AuthenticationRepository authenticationRepository;

  const UserUid(this.authenticationRepository);

  String call() {
    return authenticationRepository.getCurrentUserUid();
  }
}

class UserEmail {
  final AuthenticationRepository authenticationRepository;

  const UserEmail(this.authenticationRepository);

  String call() {
    return authenticationRepository.getCurrentUserEmail();
  }
}

class UserSignIn {
  final AuthenticationRepository authenticationRepository;

  const UserSignIn(this.authenticationRepository);

  Future<Either<Failure, void>> call({
    required String email,
    required String password,
  }) async {
    return await authenticationRepository.signIn(
      email: email,
      password: password,
    );
  }
}

class UserSignUp {
  final AuthenticationRepository authenticationRepository;

  const UserSignUp(this.authenticationRepository);

  Future<Either<Failure, void>> call({
    required String email,
    required String password,
  }) async {
    return await authenticationRepository.signUp(
      email: email,
      password: password,
    );
  }
}

class UserSignOut {
  final AuthenticationRepository authenticationRepository;

  const UserSignOut(this.authenticationRepository);

  Future<void> call() async {
    return await authenticationRepository.signOut();
  }
}
