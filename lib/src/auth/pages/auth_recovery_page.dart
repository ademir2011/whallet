import 'package:flutter/material.dart';
import 'package:whallet/src/auth/stores/auth_recovery_store.dart';
import 'package:whallet/src/widgets/auth_footer_widget.dart';
import 'package:whallet/src/widgets/auth_header_container_widget.dart';
import 'package:whallet/src/widgets/textformfield_widget.dart';

class AuthRecoveryPage extends StatefulWidget {
  const AuthRecoveryPage({Key? key}) : super(key: key);

  @override
  State<AuthRecoveryPage> createState() => _AuthRecoveryPageState();
}

class _AuthRecoveryPageState extends State<AuthRecoveryPage> {
  final authRecoveryStore = AuthRecoveryStore();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    authRecoveryStore.addListener(() => setState(() {}));
    authRecoveryStore.addFocusListeners(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return AuthHeaderContainerWidget(
      title: 'Recuperar senha',
      subtitle: 'Será enviado um e-mail para você redefinir sua senha. Informe o e-mail cadastrado',
      size: size,
      child: Column(children: [
        TextFormFieldWidget(
          hintText: 'E-mail',
          icon: const Icon(Icons.email),
          focusNode: authRecoveryStore.emailFocus,
          controller: authRecoveryStore.emailController,
          validator: authRecoveryStore.emailValidator,
        ),
        const SizedBox(height: 200),
        AuthFooterWidget(
          isLoading: authRecoveryStore.isLoading,
          title: 'Recuperar',
          onPressed: () {
            authRecoveryStore.recovery();
          },
        ),
      ]),
    );
  }
}
