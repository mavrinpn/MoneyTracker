import 'package:diploma/blocs/authentication/authentication_bloc.dart';
import 'package:diploma/core/helpers.dart';
import 'package:diploma/core/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final signFormKey = GlobalKey<FormState>();
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  ValueNotifier<bool> isSignUpAction = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
      final isLoading = state is AuthenticationLoading;
      if (state is AuthenticationError) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          showErrorAlert(context, state.message);
        });
      }

      return Scaffold(
        body: SafeArea(
          top: false,
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Image.asset(
                            'assets/images/wallet.png',
                            height: 128,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10, bottom: 10),
                            child: Text(
                              AppLocalizations.of(context)!.welcome_title,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          Text(
                            AppLocalizations.of(context)!.welcome_caption,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Form(
                          key: signFormKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              TextFormField(
                                key: const Key('emailTextField'),
                                controller: emailTextController,
                                validator: (value) =>
                                    emailValidator(value, context),
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  errorText: null,
                                  labelText:
                                      AppLocalizations.of(context)!.email,
                                ),
                              ),
                              TextFormField(
                                key: const Key('passwordTextField'),
                                controller: passwordTextController,
                                validator: (value) =>
                                    passwordValidator(value, context),
                                textInputAction: TextInputAction.done,
                                obscureText: true,
                                decoration: InputDecoration(
                                  errorText: null,
                                  labelText:
                                      AppLocalizations.of(context)!.password,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 36),
                                child: FilledButton(
                                  key: const Key('submitButton'),
                                  onPressed:
                                      isLoading ? null : signButtonAction,
                                  child: ValueListenableBuilder(
                                    valueListenable: isSignUpAction,
                                    builder: (context, value, child) {
                                      return isLoading
                                          ? const CircularProgressIndicator()
                                          : Text(isSignUpAction.value
                                              ? AppLocalizations.of(context)!
                                                  .signup
                                              : AppLocalizations.of(context)!
                                                  .signin);
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ValueListenableBuilder(
                          valueListenable: isSignUpAction,
                          builder: (context, value, child) {
                            return Text(
                              isSignUpAction.value
                                  ? AppLocalizations.of(context)!
                                      .already_have_account
                                  : AppLocalizations.of(context)!
                                      .do_not_have_account,
                            );
                          },
                        ),
                        TextButton(
                          onPressed: () {
                            isSignUpAction.value = !isSignUpAction.value;
                          },
                          child: ValueListenableBuilder(
                            valueListenable: isSignUpAction,
                            builder: (context, value, child) {
                              return Text(isSignUpAction.value
                                  ? AppLocalizations.of(context)!.signin
                                  : AppLocalizations.of(context)!.signup);
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  void signButtonAction() {
    final formValidator = signFormKey.currentState!.validate();
    if (formValidator) {
      final email = emailTextController.text;
      final password = passwordTextController.text;

      final authBloc = context.read<AuthenticationBloc>();

      isSignUpAction.value
          ? authBloc.add(AuthenticationSignUp(email: email, password: password))
          : authBloc
              .add(AuthenticationSignIn(email: email, password: password));
    }
  }
}
