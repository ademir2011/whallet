import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whallet/src/auth/bloc/auth_bloc.dart';
import 'package:whallet/src/auth/bloc/auth_event.dart';
import 'package:whallet/src/auth/bloc/auth_state.dart';
import 'package:whallet/src/auth/external/datasources/firebase_auth_signin_email_password_datasource.dart';
import 'package:whallet/src/auth/repositories/auth_repository.dart';
import 'package:whallet/src/widgets/auth_footer_widget.dart';
import 'package:whallet/src/widgets/template_container_widget.dart';
import 'package:whallet/src/widgets/textformfield_widget.dart';

class AuthSighUpPage extends StatefulWidget {
  const AuthSighUpPage({Key? key}) : super(key: key);

  @override
  State<AuthSighUpPage> createState() => _AuthSighUpPageState();
}

class _AuthSighUpPageState extends State<AuthSighUpPage> {
  final authBloc = AuthBloc(
    authRepository: AuthRepository(
      firebaseAuthEmailPasswordDatasource: FirebaseAuthEmailPasswordDatasource(firebaseAuth: FirebaseAuth.instance),
    ),
  );

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final emailFocus = FocusNode();
  final passwordFocus = FocusNode();
  final confirmPasswordFocus = FocusNode();

  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    emailFocus.dispose();
    passwordFocus.dispose();
    confirmPasswordFocus.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return TemplateContainerWidget(
      title: 'Cadastro',
      subtitle: 'Informe seus dados',
      size: size,
      child: BlocBuilder<AuthBloc, AuthState>(
        bloc: authBloc,
        builder: (context, state) {
          return Form(
            key: formKey,
            child: Column(
              children: [
                TextFormFieldWidget(
                  hintText: 'E-mail',
                  focusNode: emailFocus,
                  icon: const Icon(Icons.email),
                  controller: emailController,
                  validator: (_) {},
                ),
                const SizedBox(height: 15),
                TextFormFieldWidget(
                  hintText: 'Senha',
                  focusNode: passwordFocus,
                  controller: passwordController,
                  validator: (_) {},
                  icon: const Icon(Icons.password),
                  isPassword: true,
                ),
                const SizedBox(height: 15),
                TextFormFieldWidget(
                  hintText: 'Confirmar senha',
                  focusNode: confirmPasswordFocus,
                  controller: confirmPasswordController,
                  validator: (_) {},
                  icon: const Icon(Icons.password),
                  isPassword: true,
                ),
                const SizedBox(height: 75),
                if (state is ErrorAuthState) Text(state.message),
                AuthFooterWidget(
                  isLoading: state is LoadingAuthState,
                  title: (state is SuccessAuthState) ? 'Cadastrado' : 'Cadastrar',
                  onPressed: () {
                    if (state is! SuccessAuthState && formKey.currentState!.validate()) {
                      authBloc.add(
                        AuthSignUpEvent(
                          email: emailController.text,
                          password: passwordController.text,
                          confirmPassword: confirmPasswordController.text,
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
