import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:diploma/blocs/profile/profile_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:module_business/module_business.dart';
import 'package:module_data/module_data.dart';

//TODO: other unit tests

class MockProfileRepository extends Mock implements ProfileRepositoryImp {}

void main() {
  group('ProfileBloc', () {
    late MockProfileRepository profileRepository;

    late UploadProfilePicture uploadProfilePicture;
    late DownloadProfilePicture downloadProfilePicture;
    late DeleteProfilePicture deleteProfilePicture;

    late ProfileBloc profileBloc;

    const String imagePath = 'imagePath';

    setUp(() {
      profileRepository = MockProfileRepository();
      uploadProfilePicture = UploadProfilePicture(profileRepository);
      downloadProfilePicture = DownloadProfilePicture(profileRepository);
      deleteProfilePicture = DeleteProfilePicture(profileRepository);
      profileBloc = ProfileBloc(
        uploadProfilePicture: uploadProfilePicture,
        downloadProfilePicture: downloadProfilePicture,
        deleteProfilePicture: deleteProfilePicture,
      );
    });

    test('initial state is correct', () {
      expect(profileBloc.state, ProfileInitial());
    });

    blocTest<ProfileBloc, ProfileState>(
      'emits loading and profilePicturePath when downloadProfilePicture is success',
      setUp: () {
        when(
          () => profileRepository.downloadProfilePicture(),
        ).thenAnswer((_) async => const Right(imagePath));
      },
      build: () => profileBloc,
      act: (bloc) => bloc.add(ProfileLoad()),
      expect: () => <ProfileState>[
        ProfileLoading(),
        ProfileLoaded(profilePicturePath: imagePath)
      ],
      verify: (_) {
        verify(() => profileRepository.downloadProfilePicture()).called(1);
      },
    );

    blocTest<ProfileBloc, ProfileState>(
      'emits loading and null when downloadProfilePicture is failure',
      setUp: () {
        when(
          () => profileRepository.downloadProfilePicture(),
        ).thenAnswer((_) async => Left(ServerFailure()));
      },
      build: () => profileBloc,
      act: (bloc) => bloc.add(ProfileLoad()),
      expect: () => <ProfileState>[
        ProfileLoading(),
        ProfileLoaded(profilePicturePath: null)
      ],
      verify: (_) {
        verify(() => profileRepository.downloadProfilePicture()).called(1);
      },
    );

    blocTest<ProfileBloc, ProfileState>(
      'emits loading and profilePicturePath when uploadProfilePicture is success',
      setUp: () {
        when(
          () => profileRepository.uploadProfilePicture(imagePath),
        ).thenAnswer((_) async => const Right(null));
      },
      build: () => profileBloc,
      act: (bloc) => bloc.add(ProfileUpload(imagePath: imagePath)),
      expect: () => <ProfileState>[
        ProfileLoading(),
        ProfileLoaded(profilePicturePath: imagePath)
      ],
      verify: (_) {
        verify(() => profileRepository.uploadProfilePicture(imagePath))
            .called(1);
      },
    );

    blocTest<ProfileBloc, ProfileState>(
      'emits loading and profilePicturePath when uploadProfilePicture is failure',
      setUp: () {
        when(
          () => profileRepository.uploadProfilePicture(imagePath),
        ).thenAnswer((_) async => Left(ServerFailure()));
      },
      build: () => profileBloc,
      act: (bloc) => bloc.add(ProfileUpload(imagePath: imagePath)),
      expect: () => <ProfileState>[
        ProfileLoading(),
        ProfileLoaded(profilePicturePath: imagePath)
      ],
      verify: (_) {
        verify(() => profileRepository.uploadProfilePicture(imagePath))
            .called(1);
      },
    );

    blocTest<ProfileBloc, ProfileState>(
      'emits loading and null when deleteProfilePicture is success',
      setUp: () {
        when(
          () => profileRepository.deleteProfilePicture(),
        ).thenAnswer((_) async => const Right(null));
      },
      build: () => profileBloc,
      act: (bloc) => bloc.add(ProfileDelete()),
      expect: () => <ProfileState>[
        ProfileLoading(),
        ProfileLoaded(profilePicturePath: null)
      ],
      verify: (_) {
        verify(() => profileRepository.deleteProfilePicture()).called(1);
      },
    );

    blocTest<ProfileBloc, ProfileState>(
      'emits loading and null when deleteProfilePicture is failure',
      setUp: () {
        when(
          () => profileRepository.deleteProfilePicture(),
        ).thenAnswer((_) async => Left(ServerFailure()));
      },
      build: () => profileBloc,
      act: (bloc) => bloc.add(ProfileDelete()),
      expect: () => <ProfileState>[
        ProfileLoading(),
        ProfileLoaded(profilePicturePath: null)
      ],
      verify: (_) {
        verify(() => profileRepository.deleteProfilePicture()).called(1);
      },
    );
  });
}
