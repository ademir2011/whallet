import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:whallet/src/auth/stores/auth_signin_store.dart';
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
  final authSigninStore = AuthSigninStore();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    authSigninStore.addListener(() => setState(() {}));
    authSigninStore.addFocusListeners(() => setState(() {}));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    authSigninStore.disposeAll();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return AuthHeaderContainerWidget(
      title: 'Autenticação',
      subtitle: 'Faça login com seu e-mail e senha ou entre com sua rede social',
      size: size,
      child: Form(
        key: authSigninStore.formKey,
        child: Column(
          children: [
            TextFormFieldWidget(
              hintText: 'E-mail',
              icon: const Icon(Icons.email),
              focusNode: authSigninStore.emailFocus,
              controller: authSigninStore.emailController,
              validator: authSigninStore.emailValidator,
            ),
            const SizedBox(height: 15),
            TextFormFieldWidget(
              hintText: 'Senha',
              icon: const Icon(Icons.password),
              focusNode: authSigninStore.passwordFocus,
              isPassword: true,
              controller: authSigninStore.passwordController,
              validator: authSigninStore.passwordValidator,
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
                  isLoading: authSigninStore.isLoading,
                  onPressed: authSigninStore.submit,
                  rightIcon: Icon(
                    Icons.arrow_forward_rounded,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ],
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
      ),
    );
  }
}
