import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whallet/src/auth/bloc/auth_bloc.dart';
import 'package:whallet/src/auth/bloc/auth_state.dart';
import 'package:whallet/src/auth/services/auth_service.dart';
import 'package:whallet/src/widgets/auth_footer_widget.dart';
import 'package:whallet/src/widgets/auth_header_container_widget.dart';
import 'package:whallet/src/widgets/textformfield_widget.dart';

class AuthRecoveryPage extends StatefulWidget {
  const AuthRecoveryPage({Key? key}) : super(key: key);

  @override
  State<AuthRecoveryPage> createState() => _AuthRecoveryPageState();
}

class _AuthRecoveryPageState extends State<AuthRecoveryPage> {
  final authBloc = AuthBloc(
    authService: AuthService(),
  );

  final emailController = TextEditingController();

  final emailFocus = FocusNode();

  @override
  void dispose() {
    emailController.dispose();
    emailFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return AuthHeaderContainerWidget(
      title: 'Recuperar senha',
      subtitle: 'Será enviado um e-mail para você redefinir sua senha. Informe o e-mail cadastrado',
      size: size,
      child: BlocBuilder<AuthBloc, AuthState>(
        bloc: authBloc,
        builder: (context, state) {
          return Column(children: [
            TextFormFieldWidget(
              hintText: 'E-mail',
              icon: const Icon(Icons.email),
              focusNode: emailFocus,
              controller: emailController,
              validator: (_) {},
            ),
            const SizedBox(height: 200),
            AuthFooterWidget(
              isLoading: state is LoadingAuthState,
              title: 'Recuperar',
              onPressed: () {},
            ),
          ]);
        },
      ),
    );
  }
}
