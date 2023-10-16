import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:diploma/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Sign in / Sing out test', () {
    testWidgets('passed', (widgetTester) async {
      app.main();

      await widgetTester.pumpAndSettle();

      try {
        await signOut(widgetTester);
        await signIn(widgetTester);
      } catch (_) {
        await signIn(widgetTester);
        await signOut(widgetTester);
      }

      await Future.delayed(const Duration(seconds: 2));
    });
  });
}

Future<void> signIn(WidgetTester widgetTester) async {
  final emailTextField = find.byKey(const Key('emailTextField'));
  final passwordTextField = find.byKey(const Key('passwordTextField'));
  final submitButton = find.byKey(const Key('submitButton'));
  await Future.delayed(const Duration(seconds: 2));

  await widgetTester.enterText(emailTextField, 'test@test.ru');
  await widgetTester.enterText(passwordTextField, 'Passw0rd');
  await Future.delayed(const Duration(seconds: 2));

  await widgetTester.tap(submitButton);
  await widgetTester.pumpAndSettle();
  await Future.delayed(const Duration(seconds: 2));
}

Future<void> signOut(WidgetTester widgetTester) async {
  final profileBarItem = find.byKey(const Key('barItem2'));
  await widgetTester.tap(profileBarItem);
  await widgetTester.pumpAndSettle();
  await Future.delayed(const Duration(seconds: 2));

  final signOutButton = find.byKey(const Key('signOutButton'));
  await widgetTester.tap(signOutButton);
  await widgetTester.pumpAndSettle();
  await Future.delayed(const Duration(seconds: 2));
}
