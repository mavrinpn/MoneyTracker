import 'package:dartz/dartz.dart';
import 'package:module_business/module_business.dart';
import '../core/exception.dart';
import '../services/firebase_auth_service.dart';

class AuthenticationRepositoryImp implements AuthenticationRepository {
  FirebaseAuthService service = FirebaseAuthService();

  @override
  String getCurrentUserUid() {
    return service.getCurrentUserUid();
  }

  @override
  String getCurrentUserEmail() {
    return service.getCurrentUserEmail();
  }

  @override
  Future<Either<Failure, void>> signIn(
      {required String email, required String password}) async {
    try {
      await service.signIn(
        email: email,
        password: password,
      );
      return const Right(null);
    } on AuthenticationException catch (e) {
      return Left(AuthenticationFailure(e.errorCode));
    }
  }

  @override
  Future<Either<Failure, void>> signUp(
      {required String email, required String password}) async {
    try {
      await service.signUp(
        email: email,
        password: password,
      );
      return const Right(null);
    } on AuthenticationException catch (e) {
      return Left(AuthenticationFailure(e.errorCode));
    }
  }

  @override
  Future<void> signOut() {
    return service.signOut();
  }
}
