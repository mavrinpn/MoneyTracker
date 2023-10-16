import 'dart:io';

import 'package:diploma/theme/color_theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum AvatarButtonAction { none, delete, save }

class ProfileAvatar extends StatefulWidget {
  const ProfileAvatar({
    required this.isImageLoading,
    required this.size,
    this.avatarImage,
    this.onImageUpdated,
    this.onImageDeleted,
    super.key,
  });
  final bool isImageLoading;
  final double size;
  final Image? avatarImage;
  final Function(String imagePath)? onImageUpdated;
  final Function()? onImageDeleted;

  @override
  State<ProfileAvatar> createState() => _ProfileAvatarState();
}

class _ProfileAvatarState extends State<ProfileAvatar> {
  late bool isImageLoading;
  Image? avatarImage;
  AvatarButtonAction avatarButtonAction = AvatarButtonAction.none;
  String? imagePath;

  @override
  void initState() {
    isImageLoading = widget.isImageLoading;
    avatarImage = widget.avatarImage;
    if (widget.avatarImage != null) {
      avatarButtonAction = AvatarButtonAction.delete;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colorTheme = Theme.of(context).extension<ColorThemeExtension>()!;

    List<Widget> avatarColumn = [];
    avatarColumn.add(
      CircleAvatar(
        radius: widget.size / 2,
        foregroundImage: isImageLoading ? null : avatarImage?.image,
        backgroundColor: colorTheme.avatarBackgroundColor,
        child: Material(
          shape: const CircleBorder(),
          clipBehavior: Clip.hardEdge,
          color: Colors.transparent,
          child: InkWell(
            onTap: () => imagePickerAction(),
            child: SizedBox(
              width: widget.size,
              height: widget.size,
              child: isImageLoading
                  ? const CircularProgressIndicator()
                  : Icon(
                      Icons.camera_alt,
                      color: colorTheme.placeholderColor,
                      size: widget.size / 3,
                    ),
            ),
          ),
        ),
      ),
    );

    if (avatarButtonAction == AvatarButtonAction.delete) {
      avatarColumn.add(
        TextButton(
          onPressed: () => imageDeleteAction(),
          child: Text(AppLocalizations.of(context)!.delete),
        ),
      );
    } else if (avatarButtonAction == AvatarButtonAction.save) {
      avatarColumn.add(
        TextButton(
          onPressed: () => imageSaveAction(),
          child: Text(AppLocalizations.of(context)!.save),
        ),
      );
    }

    return Column(
      children: avatarColumn,
    );
  }

  void imageSaveAction() {
    if (widget.onImageUpdated != null && imagePath != null) {
      widget.onImageUpdated!(imagePath!);
    }
    setState(() {
      avatarButtonAction = AvatarButtonAction.delete;
    });
  }

  void imageDeleteAction() {
    if (widget.onImageDeleted != null) {
      widget.onImageDeleted!();
    }

    setState(() {
      avatarImage = null;
      avatarButtonAction = AvatarButtonAction.none;
    });
  }

  void imagePickerAction() {
    setState(() {
      isImageLoading = true;
    });

    ImagePicker picker = ImagePicker();
    picker
        .pickImage(
      source: ImageSource.gallery,
      maxWidth: 256,
      maxHeight: 256,
    )
        .then((image) {
      if (image != null) {
        setState(() {
          avatarButtonAction = AvatarButtonAction.save;
          avatarImage = Image.file(File(image.path));
          imagePath = image.path;
          isImageLoading = false;
        });
      }
    }).whenComplete(() {
      setState(() {
        isImageLoading = false;
      });
    });
  }
}
