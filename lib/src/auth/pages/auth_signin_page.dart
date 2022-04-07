import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whallet/src/auth/bloc/auth_bloc.dart';
import 'package:whallet/src/auth/bloc/auth_event.dart';
import 'package:whallet/src/auth/bloc/auth_state.dart';
import 'package:whallet/src/auth/repositories/auth_repository.dart';
import 'package:whallet/src/widgets/auth_header_container_widget.dart';
import 'package:whallet/src/widgets/elevated_button_widget.dart';
import 'package:whallet/src/widgets/textformfield_widget.dart';
import 'package:whallet/utils/routes.dart';

class AuthSigninPage extends StatefulWidget {
  const AuthSigninPage({Key? key}) : super(key: key);

  @override
  State<AuthSigninPage> createState() => _AuthSigninPageState();
}

class _AuthSigninPageState extends State<AuthSigninPage> {
  final authBloc = AuthBloc(authRepository: AuthRepository());
  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final emailFocus = FocusNode();
  final passwordFocus = FocusNode();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    emailController.dispose();
    passwordController.dispose();
    emailFocus.dispose();
    passwordFocus.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return AuthHeaderContainerWidget(
      title: 'Autenticação',
      subtitle: 'Faça login com seu e-mail e senha ou entre com sua rede social',
      size: size,
      child: BlocListener(
        bloc: authBloc,
        listener: (ctx, state) {
          if (state is SuccessAuthState) Navigator.of(context).pushNamed(AppRoute.PORTFOLIO_HOME);
        },
        child: BlocBuilder<AuthBloc, AuthState>(
          bloc: authBloc,
          builder: (ctx, state) {
            if (state is SuccessAuthState) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is AuthInitialState) {
              return Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormFieldWidget(
                      hintText: 'E-mail',
                      icon: const Icon(Icons.email),
                      focusNode: emailFocus,
                      controller: emailController,
                      validator: (v) => (v ?? '').isEmpty ? 'Vazio' : null,
                    ),
                    const SizedBox(height: 15),
                    TextFormFieldWidget(
                      hintText: 'Senha',
                      icon: const Icon(Icons.password),
                      focusNode: passwordFocus,
                      controller: passwordController,
                      isPassword: true,
                      validator: (v) => (v ?? '').isEmpty ? 'Vazio' : null,
                    ),
                    const SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () => Navigator.pushNamed(
                            context,
                            AppRoute.AUTH_RECOVERY,
                          ),
                          child: Text(
                            'Esqueceu sua senha?',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                        ElevatedButtonWidget(
                          title: 'Entrar',
                          isLoading: state is LoadingAuthState ? true : false,
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              authBloc.add(
                                AuthSignInEvent(
                                  email: emailController.text,
                                  password: passwordController.text,
                                ),
                              );
                            }
                          },
                          rightIcon: Icon(
                            Icons.arrow_forward_rounded,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                      ],
                    ),
                    if (state is ErrorAuthState) const SizedBox(height: 50),
                    if (state is ErrorAuthState)
                      Text(
                        'Ocorreu um erro. Por favor, tente novamente.',
                        style: TextStyle(
                          color: Theme.of(context).errorColor,
                        ),
                      ),
                    const SizedBox(height: 50),
                    SizedBox(
                      width: double.infinity,
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: 'Não quer entrar por redes sociais?\n',
                          style: Theme.of(context).textTheme.bodySmall,
                          children: <TextSpan>[
                            TextSpan(
                              text: 'CADASTRE-SE AQUI',
                              style: Theme.of(context).textTheme.bodyLarge,
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => Navigator.pushNamed(
                                      context,
                                      AppRoute.AUTH_SIGNUP,
                                    ),
                            ),
                            TextSpan(
                              text: ' com e-mail e senha!',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }

            if (state is ErrorAuthState) {
              return const Center(
                child: Text('Erro'),
              );
            }

            return const Center(
              child: Text('Erro'),
            );
          },
        ),
      ),
    );
  }
}
