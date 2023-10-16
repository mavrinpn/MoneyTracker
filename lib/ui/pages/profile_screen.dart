import 'dart:io';

import 'package:diploma/blocs/authentication/authentication_bloc.dart';
import 'package:diploma/blocs/profile/profile_bloc.dart';
import 'package:diploma/ui/widgets/profile/profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.profile_tab),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: SizedBox(
          child: Row(
            children: [
              BlocBuilder<ProfileBloc, ProfileState>(
                builder: (context, state) {
                  final profilePicturePath = (state is ProfileLoaded)
                      ? state.profilePicturePath
                      : null;
                  return ProfileAvatar(
                    key: UniqueKey(),
                    isImageLoading: state is ProfileLoading,
                    avatarImage: profilePicturePath == null
                        ? null
                        : Image.file(File(profilePicturePath)),
                    size: 100,
                    onImageUpdated: (imagePath) async {
                      context
                          .read<ProfileBloc>()
                          .add(ProfileUpload(imagePath: imagePath));
                    },
                    onImageDeleted: () async {
                      context.read<ProfileBloc>().add(ProfileDelete());
                    },
                  );
                },
              ),
              const SizedBox(width: 25),
              Expanded(
                child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
                  builder: (context, state) {
                    final email =
                        state is AuthenticationSuccess ? state.email : '';
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(email),
                        const SizedBox(height: 20),
                        FilledButton(
                          key: const Key('signOutButton'),
                          onPressed: () {
                            context
                                .read<AuthenticationBloc>()
                                .add(AuthenticationSignOut());
                          },
                          child: Text(AppLocalizations.of(context)!.logout),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
