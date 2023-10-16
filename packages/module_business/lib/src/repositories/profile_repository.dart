import 'package:dartz/dartz.dart';
import 'package:module_business/module_business.dart';

abstract class ProfileRepository {
  Future<Either<Failure, void>> uploadProfilePicture(String imagePath);
  Future<Either<Failure, void>> deleteProfilePicture();
  Future<Either<Failure, String>> downloadProfilePicture();
}
