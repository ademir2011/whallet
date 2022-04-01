import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whallet/src/auth/bloc/auth_bloc.dart';
import 'package:whallet/src/portifolio/bloc_token/token_bloc.dart';
import 'package:whallet/src/portifolio/bloc_token/token_event.dart';
import 'package:whallet/src/portifolio/bloc_token/token_state.dart';
import 'package:whallet/src/portifolio/datasources/coingecko_datasource.dart';
import 'package:whallet/src/portifolio/datasources/pancakeswap_datasource.dart';
import 'package:whallet/src/portifolio/models/token_model.dart';
import 'package:whallet/src/portifolio/repository/token_repository.dart';
import 'package:whallet/src/portifolio/services/token_service.dart';
import 'package:whallet/src/widgets/elevated_button_widget.dart';
import 'package:whallet/src/widgets/label_symbol_dialog_widget.dart';
import 'package:whallet/src/widgets/outlined_button_widget.dart';
import 'package:whallet/src/widgets/textformfield_widget.dart';

class CriptoDialogWidget extends StatefulWidget {
  final String title;
  final String subtitle;

  const CriptoDialogWidget({
    Key? key,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  @override
  State<CriptoDialogWidget> createState() => _CriptoDialogWidgetState();
}

class _CriptoDialogWidgetState extends State<CriptoDialogWidget> {
  final tokenBloc = TokenBloc(
    tokenService: TokenService(TokenRepository(CoingeckoDatasource(), PancakeswapDatasource())),
    formKey: GlobalKey<FormState>(),
    selectedToken: TokenModel(),
    tokenController: TextEditingController(),
    tokenFocus: FocusNode(),
  );
  late StreamSubscription sub;

  @override
  void dispose() {
    tokenBloc.tokenController.dispose();
    tokenBloc.tokenFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      title: Text(widget.title),
      content: SizedBox(
        height: 450,
        child: BlocBuilder<TokenBloc, TokenState>(
          bloc: tokenBloc,
          builder: (context, state) {
            return Form(
              key: tokenBloc.formKey,
              child: Column(
                children: [
                  Text(
                    widget.subtitle,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 20),
                  TextFormFieldWidget(
                    hintText: 'Buscar Cripto',
                    icon: const Icon(Icons.abc),
                    validator: (_) {},
                    controller: tokenBloc.tokenController,
                    focusNode: tokenBloc.tokenFocus,
                    textInputAction: TextInputAction.search,
                    onSubmitted: (value) {
                      tokenBloc.add(FetchTokensEvent(tokenModel: TokenModel(symbol: value)));
                    },
                  ),
                  const SizedBox(height: 10),
                  if (state is LoadingTokenState) const Center(child: CircularProgressIndicator()),
                  if (state is SuccessTokenState)
                    SizedBox(
                      height: 200,
                      width: MediaQuery.of(context).size.width,
                      child: GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 15,
                          childAspectRatio: 4 / 2,
                        ),
                        itemCount: state.tokens.length,
                        itemBuilder: (context, index) {
                          print(tokenBloc.selectedToken);
                          return LabelSymbolDialogWidget(
                            symbleName: state.tokens[index].symbol ?? '',
                            selected: tokenBloc.selectedToken == state.tokens[index],
                            onTap: () {
                              tokenBloc.selectedToken = tokenBloc.selectedToken.symbol == state.tokens[index].symbol
                                  ? TokenModel()
                                  : state.tokens[index];

                              tokenBloc.add(SelectTokenEvent(tokens: state.tokens));
                            },
                          );
                        },
                      ),
                    ),
                  const SizedBox(height: 10),
                  const Spacer(),
                  if (state is ErrorTokenState)
                    Center(
                      child: Text(
                        state.message,
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Theme.of(context).errorColor),
                      ),
                    ),
                  if (state is ErrorTokenState) const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      OutlineButtonWidget(onPressed: () => Navigator.of(context).pop(), title: 'Fechar'),
                      ElevatedButtonWidget(
                        onPressed: () => tokenBloc.add(CreateTokenEvent(tokenModel: tokenBloc.selectedToken)),
                        title: 'Adicionar',
                      ),
                    ],
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
