import 'package:diploma/app/go_router.dart';
import 'package:diploma/blocs/authentication/authentication_bloc.dart';
import 'package:diploma/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MoneyTrackerApp extends StatelessWidget {
  const MoneyTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    final authenticationBloc = context.read<AuthenticationBloc>();

    return MaterialApp.router(
      title: 'Money Tracker',
      routerConfig: goRouter(authenticationBloc),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('ru'),
      ],
      theme: AppTheme.getThemeFor(ThemeMode.light),
      darkTheme: AppTheme.getThemeFor(ThemeMode.dark),
      themeMode: ThemeMode.system,
    );
  }
}
