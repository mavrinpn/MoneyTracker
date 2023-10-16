import 'package:flutter/material.dart';
import 'package:theme_extensions_builder_annotation/theme_extensions_builder_annotation.dart';

part 'color_theme_extension.g.theme.dart';

@themeExtensions
class ColorThemeExtension extends ThemeExtension<ColorThemeExtension>
    with _$ThemeExtensionMixin {
  const ColorThemeExtension({
    required this.themeMode,
    required this.accentColor,
    required this.scaffoldBackgroundColor,
    required this.headerTitleColor,
    required this.headerBackgroundColor,
    required this.bottomBackgroundColor,
    required this.selectedItemColor,
    required this.unselectedItemColor,
    required this.subviewBackgroundColor,
    required this.primaryButtonColor,
    required this.secondaryButtonColor,
    required this.successButtonColor,
    required this.warningButtonColor,
    required this.dangerButtonColor,
    required this.buttonLabelColor,
    required this.placeholderColor,
    required this.titleTextColor,
    required this.subtitleTextColor,
    required this.tileBackgroundColor,
    required this.avatarBackgroundColor,
  });

  final ThemeMode themeMode;
  final Color accentColor;
  final Color scaffoldBackgroundColor;
  final Color headerTitleColor;
  final Color headerBackgroundColor;
  final Color bottomBackgroundColor;
  final Color selectedItemColor;
  final Color unselectedItemColor;
  final Color subviewBackgroundColor;
  final Color primaryButtonColor;
  final Color secondaryButtonColor;
  final Color successButtonColor;
  final Color warningButtonColor;
  final Color dangerButtonColor;
  final Color buttonLabelColor;
  final Color placeholderColor;
  final Color titleTextColor;
  final Color subtitleTextColor;
  final Color tileBackgroundColor;
  final Color avatarBackgroundColor;
}
