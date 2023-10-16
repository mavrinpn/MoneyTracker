part of 'profile_bloc.dart';

@immutable
sealed class ProfileState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class ProfileInitial extends ProfileState {
  @override
  List<Object?> get props => [];
}

final class ProfileLoading extends ProfileState {
  @override
  List<Object?> get props => [];
}

final class ProfileLoaded extends ProfileState {
  final String? profilePicturePath;

  ProfileLoaded({required this.profilePicturePath});

  @override
  List<Object?> get props => [profilePicturePath];
}
