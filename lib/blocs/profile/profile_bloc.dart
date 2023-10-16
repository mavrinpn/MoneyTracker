import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:module_business/module_business.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final UploadProfilePicture uploadProfilePicture;
  final DownloadProfilePicture downloadProfilePicture;
  final DeleteProfilePicture deleteProfilePicture;

  ProfileBloc({
    required this.uploadProfilePicture,
    required this.downloadProfilePicture,
    required this.deleteProfilePicture,
  }) : super(ProfileInitial()) {
    on<ProfileLoad>((event, emit) async {
      emit(ProfileLoading());

      final failuerOrProfilePicturePath = await downloadProfilePicture();
      failuerOrProfilePicturePath.fold((failure) {
        emit(ProfileLoaded(profilePicturePath: null));
      }, (imagePath) {
        emit(ProfileLoaded(profilePicturePath: imagePath));
      });
    });

    on<ProfileUpload>((event, emit) async {
      emit(ProfileLoading());

      await uploadProfilePicture(event.imagePath);

      emit(ProfileLoaded(profilePicturePath: event.imagePath));
    });

    on<ProfileDelete>((event, emit) async {
      emit(ProfileLoading());

      await deleteProfilePicture();

      emit(ProfileLoaded(profilePicturePath: null));
    });
  }
}
