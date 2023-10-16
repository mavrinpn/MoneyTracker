import 'package:dartz/dartz.dart';
import 'package:module_business/module_business.dart';

class UploadProfilePicture {
  final ProfileRepository profileRepository;

  const UploadProfilePicture(this.profileRepository);

  Future<Either<Failure, void>> call(String imagePath) async {
    return await profileRepository.uploadProfilePicture(imagePath);
  }
}

class DeleteProfilePicture {
  final ProfileRepository profileRepository;

  const DeleteProfilePicture(this.profileRepository);

  Future<Either<Failure, void>> call() async {
    return await profileRepository.deleteProfilePicture();
  }
}

class DownloadProfilePicture {
  final ProfileRepository profileRepository;

  const DownloadProfilePicture(this.profileRepository);

  Future<Either<Failure, String>> call() async {
    return await profileRepository.downloadProfilePicture();
  }
}
