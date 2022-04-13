import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whallet/src/portifolio/bloc_token/token_bloc.dart';
import 'package:whallet/src/portifolio/bloc_token/token_event.dart';
import 'package:whallet/src/portifolio/bloc_token/token_state.dart';
import 'package:whallet/src/portifolio/datasources/coingecko_datasource.dart';
import 'package:whallet/src/portifolio/datasources/pancakeswap_datasource.dart';
import 'package:whallet/src/portifolio/models/token_model.dart';
import 'package:whallet/src/portifolio/repository/token_repository.dart';
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
  final formKey = GlobalKey<FormState>();
  var selectedToken = TokenModel();
  final tokenController = TextEditingController();
  final tokenFocus = FocusNode();
  final tokenBloc = TokenBloc(
    tokenRepository: TokenRepository(
      coingeckoDatasource: CoingeckoDatasource(),
      pancakeswapDatasource: PancakeswapDatasource(),
      firebaseFirestore: FirebaseFirestore.instance,
      dio: Dio(),
    ),
  );
  late StreamSubscription sub;

  @override
  void dispose() {
    tokenController.dispose();
    tokenFocus.dispose();
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
            if (state is SuccessSelectTokenState) {
              selectedToken = state.selectedToken;
            }

            return Form(
              key: formKey,
              child: Column(
                children: [
                  Text(
                    widget.subtitle,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 20),
                  TextFormFieldWidget(
                    autofocus: true,
                    hintText: 'Buscar Cripto',
                    icon: const Icon(Icons.abc),
                    validator: (_) {},
                    controller: tokenController,
                    focusNode: tokenFocus,
                    textInputAction: TextInputAction.search,
                    onSubmitted: (value) {
                      tokenBloc.add(FetchTokensEvent(tokenModel: TokenModel(symbol: value)));
                    },
                  ),
                  const SizedBox(height: 10),
                  if (state is LoadingTokenState) const Center(child: CircularProgressIndicator()),
                  if (state is SuccessTokenSaveState)
                    Center(
                      child: Text(
                        'Token adicionado com sucesso.',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  if (state is SuccessTokenState || state is SuccessSelectTokenState)
                    SizedBox(
                      height: 200,
                      width: MediaQuery.of(context).size.width,
                      child: GridTokensWidget(
                        state: state,
                        tokenBloc: tokenBloc,
                        selectedToken: selectedToken,
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
                      OutlinedButtonWidget(onPressed: () => Navigator.of(context).pop(), title: 'Fechar'),
                      ElevatedButtonWidget(
                        onPressed: () => tokenBloc.add(CreateTokenEvent(tokenModel: selectedToken)),
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

class GridTokensWidget extends StatelessWidget {
  final dynamic state;
  TokenModel selectedToken;
  GridTokensWidget({
    Key? key,
    required this.state,
    required this.tokenBloc,
    required this.selectedToken,
  }) : super(key: key);

  final TokenBloc tokenBloc;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 10,
        crossAxisSpacing: 15,
        childAspectRatio: 4 / 2,
      ),
      itemCount: state.tokens.length,
      itemBuilder: (context, index) {
        return LabelSymbolDialogWidget(
          symbleName: state.tokens[index].symbol ?? '',
          selected: selectedToken == state.tokens[index],
          onTap: () {
            selectedToken = selectedToken.symbol == state.tokens[index].symbol ? TokenModel() : state.tokens[index];

            tokenBloc.add(SelectTokenEvent(tokens: state.tokens, selectedToken: selectedToken));
          },
        );
      },
    );
  }
}
