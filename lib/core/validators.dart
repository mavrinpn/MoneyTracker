import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

String? nameValidator(String? value, BuildContext context) {
  if (value == null || value.isEmpty) {
    return AppLocalizations.of(context)!.enter_name;
  }
  return null;
}

String? doubleValidator(String? value, BuildContext context) {
  if (value == null || value.isEmpty) {
    return AppLocalizations.of(context)!.enter_number;
  }
  if (double.tryParse(value) == null) {
    return AppLocalizations.of(context)!.enter_number;
  }
  return null;
}

String? dateValidator(String? value, BuildContext context) {
  if (value == null || value.isEmpty) {
    return AppLocalizations.of(context)!.enter_date;
  }
  final regexDate = RegExp(r'(0[1-9]|[12][0-9]|3[01])/(0[1-9]|1[012])/\d\d');
  if (!regexDate.hasMatch(value)) {
    return AppLocalizations.of(context)!.enter_valid_date;
  }
  return null;
}

String? colorValidator(String? value, BuildContext context) {
  if (value == null || value.isEmpty) {
    return AppLocalizations.of(context)!.enter_color;
  }
  final regexOneDigit = RegExp(r'[A-Fa-f0-9]{6}');
  if (!regexOneDigit.hasMatch(value)) {
    return AppLocalizations.of(context)!.enter_valid_color;
  }
  return null;
}

String? emailValidator(String? value, BuildContext context) {
  if (value == null || value.isEmpty) {
    return AppLocalizations.of(context)!.enter_email;
  }
  if (!EmailValidator.validate(value)) {
    return AppLocalizations.of(context)!.enter_valid_email;
  }
  return null;
}

String? passwordValidator(String? value, BuildContext context) {
  if (value == null || value.isEmpty) {
    return AppLocalizations.of(context)!.enter_password;
  }
  if (value.length < 8) {
    return AppLocalizations.of(context)!.must_contain_8_chars;
  }
  final regexOneDigit = RegExp(r'[0-9]');
  if (!regexOneDigit.hasMatch(value)) {
    return AppLocalizations.of(context)!.must_contain_1_digit;
  }
  final regexOneUpper = RegExp(r'[A-Z]');
  if (!regexOneUpper.hasMatch(value)) {
    return AppLocalizations.of(context)!.must_contain_1_upper;
  }
  final regexOneLower = RegExp(r'[a-z]');
  if (!regexOneLower.hasMatch(value)) {
    return AppLocalizations.of(context)!.must_contain_1_lower;
  }
  return null;
}
