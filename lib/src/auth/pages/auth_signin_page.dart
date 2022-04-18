import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:whallet/src/auth/bloc/auth_bloc.dart';
import 'package:whallet/src/auth/bloc/auth_event.dart';
import 'package:whallet/src/auth/bloc/auth_state.dart';
import 'package:whallet/src/widgets/template_container_widget.dart';
import 'package:whallet/src/widgets/elevated_button_widget.dart';
import 'package:whallet/src/widgets/textformfield_widget.dart';
import 'package:whallet/utils/routes.dart';

class AuthSigninPage extends StatefulWidget {
  const AuthSigninPage({Key? key}) : super(key: key);

  @override
  State<AuthSigninPage> createState() => _AuthSigninPageState();
}

class _AuthSigninPageState extends State<AuthSigninPage> {
  final authBloc = Modular.get<AuthBloc>();
  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final emailFocus = FocusNode();
  final passwordFocus = FocusNode();
  var hasCredentialData = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      authBloc.add(CheckDataCredentialEvent());
    });
  }

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

    return TemplateContainerWidget(
      title: 'Autenticação',
      subtitle: 'Faça login com seu e-mail e senha ou entre com sua rede social',
      size: size,
      isOptions: true,
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

            if (state is SuccessCredentialAuthState) {
              if (state.email.isNotEmpty && state.password.isNotEmpty) {
                emailController.text = state.email;
                passwordController.text = state.password;
              }
              hasCredentialData = state.checkDataCredential;
            }

            return Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormFieldWidget(
                    hintText: 'E-mail',
                    icon: Icon(
                      Icons.email,
                      color: Theme.of(context).textTheme.bodyMedium!.color,
                    ),
                    focusNode: emailFocus,
                    controller: emailController,
                    validator: (v) => (v ?? '').isEmpty ? 'Vazio' : null,
                  ),
                  const SizedBox(height: 15),
                  TextFormFieldWidget(
                    hintText: 'Senha',
                    icon: Icon(
                      Icons.password,
                      color: Theme.of(context).textTheme.bodyMedium!.color,
                    ),
                    focusNode: passwordFocus,
                    controller: passwordController,
                    isPassword: true,
                    validator: (v) => (v ?? '').isEmpty ? 'Vazio' : null,
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      if (state is LoadingCheckCredentialAuthState)
                        const Padding(
                          padding: EdgeInsets.all(15),
                          child: SizedBox(height: 15, width: 15, child: CircularProgressIndicator()),
                        ),
                      if (state is! LoadingCheckCredentialAuthState)
                        Checkbox(
                          activeColor: Theme.of(context).colorScheme.primary,
                          value: hasCredentialData,
                          onChanged: (value) {
                            if (value ?? false) {
                              authBloc.add(
                                AuthSaveCredentialEvent(email: emailController.text, password: passwordController.text),
                              );
                            } else {
                              authBloc.add(
                                AuthRemoveCredentialEvent(),
                              );
                            }
                          },
                        ),
                      Text(
                        'Salvar dados de acesso',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
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
          },
        ),
      ),
    );
  }
}
