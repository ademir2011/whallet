import 'package:flutter/material.dart';
import 'package:whallet/src/auth/stores/auth_signup_store.dart';
import 'package:whallet/src/widgets/auth_footer_widget.dart';
import 'package:whallet/src/widgets/auth_header_container_widget.dart';
import 'package:whallet/src/widgets/elevated_button_widget.dart';
import 'package:whallet/src/widgets/textformfield_widget.dart';

class AuthSighUpPage extends StatefulWidget {
  const AuthSighUpPage({Key? key}) : super(key: key);

  @override
  State<AuthSighUpPage> createState() => _AuthSighUpPageState();
}

class _AuthSighUpPageState extends State<AuthSighUpPage> {
  final authSignUpStore = AuthSignUpStore();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    authSignUpStore.addListener(() => setState(() {}));
    authSignUpStore.addFocusListeners(() => setState(() {}));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    authSignUpStore.disposeAll();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return AuthHeaderContainerWidget(
      title: 'Cadastro',
      subtitle: 'Informe seus dados',
      size: size,
      child: Form(
        key: authSignUpStore.formKey,
        child: Column(
          children: [
            TextFormFieldWidget(
              hintText: 'E-mail',
              focusNode: authSignUpStore.emailFocus,
              icon: const Icon(Icons.email),
              controller: authSignUpStore.emailController,
              validator: authSignUpStore.emailValidator,
            ),
            const SizedBox(height: 15),
            TextFormFieldWidget(
              hintText: 'Senha',
              focusNode: authSignUpStore.passwordFocus,
              controller: authSignUpStore.passwordController,
              validator: authSignUpStore.passwordValidator,
              icon: const Icon(Icons.password),
              isPassword: true,
            ),
            const SizedBox(height: 15),
            TextFormFieldWidget(
              hintText: 'Confirmar senha',
              focusNode: authSignUpStore.confirmPasswordFocus,
              controller: authSignUpStore.confirmPasswordController,
              validator: authSignUpStore.confirmPasswordValidator,
              icon: const Icon(Icons.password),
              isPassword: true,
            ),
            const SizedBox(height: 75),
            AuthFooterWidget(
              isLoading: authSignUpStore.isLoading,
              title: 'Cadastrar',
              onPressed: authSignUpStore.submit,
            ),
          ],
        ),
      ),
    );
  }
}
