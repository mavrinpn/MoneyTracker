import 'package:dartz/dartz.dart';
import 'package:module_business/module_business.dart';

abstract class AuthenticationRepository {
  String getCurrentUserUid();
  String getCurrentUserEmail();
  Future<Either<Failure, void>> signUp({
    required String email,
    required String password,
  });
  Future<Either<Failure, void>> signIn({
    required String email,
    required String password,
  });
  Future<void> signOut();
}
