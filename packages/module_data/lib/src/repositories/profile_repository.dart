import 'package:dartz/dartz.dart';
import 'package:module_business/module_business.dart';
import '../services/firebase_storage_service.dart';

class ProfileRepositoryImp implements ProfileRepository {
  final FirebaseStorageService service = FirebaseStorageService();

  @override
  Future<Either<Failure, void>> uploadProfilePicture(String imagePath) async {
    try {
      await service.uploadProfilePicture(imagePath);
      return const Right(null);
    } catch (_) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deleteProfilePicture() async {
    try {
      await service.deleteProfilePicture();
      return const Right(null);
    } catch (_) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, String>> downloadProfilePicture() async {
    try {
      final imagePath = await service.downloadProfilePicture();
      return Right(imagePath);
    } catch (_) {
      return Left(ServerFailure());
    }
  }
}
