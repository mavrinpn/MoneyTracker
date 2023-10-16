part of 'profile_bloc.dart';

@immutable
sealed class ProfileEvent {}

class ProfileLoad extends ProfileEvent {}

class ProfileUpload extends ProfileEvent {
  final String imagePath;

  ProfileUpload({required this.imagePath});
}

class ProfileDelete extends ProfileEvent {}
