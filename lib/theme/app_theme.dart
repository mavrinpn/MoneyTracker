import 'package:diploma/theme/color_theme_extension.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static const accentColor = Color(0xFF9053EB);
  static const _buttonHeight = 50.0;
  static const _fontFamily = 'SF UI Display';

  static const _whiteColor = Color(0xFFFFFFFF);
  static const _blackColor = Color(0xFF111111);
  static const _greyColor = Color(0xFFABABAB);
  static const _lightGreyColor = Color(0xFFF1F1F1);
  static const _redColor = Color(0xFFF36969);
  static const _greenColor = Color(0xFF28a745);
  static const _orangeColor = Color(0xFFFFC109);
  static const _lightVioletColor = Color(0xFF8D6CEA);
  static const _deepBlack = Color(0xFF181818);
  static const _blackMatte = Color(0xFF343434);

  static const lightColorProfile = ColorThemeExtension(
    themeMode: ThemeMode.light,
    accentColor: accentColor,
    scaffoldBackgroundColor: _whiteColor,
    headerTitleColor: _whiteColor,
    headerBackgroundColor: accentColor,
    bottomBackgroundColor: _whiteColor,
    selectedItemColor: accentColor,
    unselectedItemColor: _greyColor,
    subviewBackgroundColor: _lightGreyColor,
    primaryButtonColor: accentColor,
    secondaryButtonColor: accentColor,
    successButtonColor: _greenColor,
    warningButtonColor: _orangeColor,
    dangerButtonColor: _redColor,
    buttonLabelColor: _whiteColor,
    placeholderColor: _greyColor,
    titleTextColor: _blackColor,
    subtitleTextColor: _greyColor,
    tileBackgroundColor: _whiteColor,
    avatarBackgroundColor: _lightGreyColor,
  );

  static const darkColorProfile = ColorThemeExtension(
    themeMode: ThemeMode.dark,
    accentColor: _lightVioletColor,
    scaffoldBackgroundColor: _deepBlack,
    headerTitleColor: _lightGreyColor,
    headerBackgroundColor: _lightVioletColor,
    bottomBackgroundColor: _blackMatte,
    selectedItemColor: _lightVioletColor,
    unselectedItemColor: _greyColor,
    subviewBackgroundColor: _blackMatte,
    primaryButtonColor: _lightVioletColor,
    secondaryButtonColor: _lightVioletColor,
    successButtonColor: _greenColor,
    warningButtonColor: _orangeColor,
    dangerButtonColor: _redColor,
    buttonLabelColor: _lightGreyColor,
    placeholderColor: _greyColor,
    titleTextColor: _lightGreyColor,
    subtitleTextColor: _greyColor,
    tileBackgroundColor: _blackMatte,
    avatarBackgroundColor: _blackMatte,
  );

  static getThemeFor(ThemeMode themeMode) {
    final ColorThemeExtension colorTheme =
        themeMode == ThemeMode.light ? lightColorProfile : darkColorProfile;
    final theme = themeMode == ThemeMode.light
        ? ThemeData.light(useMaterial3: true)
        : ThemeData.dark(useMaterial3: true);
    final textTheme = themeMode == ThemeMode.light
        ? ThemeData.light().textTheme.apply(
              fontFamily: _fontFamily,
            )
        : ThemeData.dark().textTheme.apply(
              fontFamily: _fontFamily,
            );

    return theme.copyWith(
      textTheme: textTheme,
      extensions: <ThemeExtension<dynamic>>[
        colorTheme,
      ],
      colorScheme: ThemeData().colorScheme.copyWith(
            primary: colorTheme.accentColor,
          ),
      scaffoldBackgroundColor: colorTheme.scaffoldBackgroundColor,
      appBarTheme: AppBarTheme(
        backgroundColor: colorTheme.headerBackgroundColor,
        foregroundColor: colorTheme.headerTitleColor,
        centerTitle: true,
        titleTextStyle: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: colorTheme.bottomBackgroundColor,
        selectedItemColor: colorTheme.selectedItemColor,
        unselectedItemColor: colorTheme.unselectedItemColor,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size.fromHeight(_buttonHeight),
          backgroundColor: colorTheme.primaryButtonColor,
          foregroundColor: colorTheme.buttonLabelColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          textStyle: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size.fromHeight(_buttonHeight),
          foregroundColor: colorTheme.dangerButtonColor,
          side: const BorderSide(color: Colors.transparent),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          textStyle: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: colorTheme.accentColor,
          textStyle: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: TextStyle(
          color: colorTheme.placeholderColor,
        ),
        floatingLabelStyle: TextStyle(
          color: colorTheme.accentColor,
        ),
        hintStyle: TextStyle(
          color: colorTheme.placeholderColor,
        ),
        counterStyle: TextStyle(
          color: colorTheme.placeholderColor,
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: colorTheme.accentColor),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: colorTheme.placeholderColor),
        ),
      ),
      dialogTheme: DialogTheme(
        surfaceTintColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        titleTextStyle: TextStyle(
          color: colorTheme.titleTextColor,
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
