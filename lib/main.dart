// ignore: depend_on_referenced_packages
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:diploma/blocs/profile/profile_bloc.dart';
import 'package:diploma/blocs/authentication/authentication_bloc.dart';
import 'package:diploma/core/locator.dart';
import 'package:diploma/blocs/categories/categories_bloc.dart';
import 'package:diploma/app/money_tracker_app.dart';
import 'package:diploma/blocs/app_bloc_observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:intl/intl_standalone.dart';
import 'package:module_data/module_data.dart';

const showDebug = false;

void main() async {
  usePathUrlStrategy(); // turn off the # in the URLs on the web
  Intl.systemLocale = await findSystemLocale();
  initServiceLocator();
  await initDataServices();
  if (showDebug) {
    Bloc.observer = AppBlocObserver();
  }

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(
          create: (context) =>
              sl<AuthenticationBloc>()..add(AuthenticationStarted()),
        ),
        BlocProvider<CategoriesBloc>(
          create: (context) => sl<CategoriesBloc>(),
        ),
        BlocProvider<ProfileBloc>(
          create: (context) => sl<ProfileBloc>()..add(ProfileLoad()),
        )
      ],
      child: const MoneyTrackerApp(),
    ),
  );
}
