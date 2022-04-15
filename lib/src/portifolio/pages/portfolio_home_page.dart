import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whallet/src/portifolio/bloc_portfolio/portfolio_bloc.dart';
import 'package:whallet/src/portifolio/bloc_portfolio/portfolio_event.dart';
import 'package:whallet/src/portifolio/bloc_portfolio/portfolio_state.dart';
import 'package:whallet/src/portifolio/datasources/coingecko_datasource.dart';
import 'package:whallet/src/portifolio/datasources/pancakeswap_datasource.dart';
import 'package:whallet/src/portifolio/repository/portfolio_repository.dart';
import 'package:whallet/src/portifolio/repository/token_repository.dart';
import 'package:whallet/src/widgets/template_container_widget.dart';
import 'package:whallet/src/widgets/card_price_widget.dart';
import 'package:whallet/src/widgets/cripto_dialog_widget.dart';
import 'package:whallet/utils/routes.dart';

class PortfolioHomePage extends StatefulWidget {
  const PortfolioHomePage({Key? key}) : super(key: key);

  @override
  State<PortfolioHomePage> createState() => _PortfolioHomePageState();
}

class _PortfolioHomePageState extends State<PortfolioHomePage> {
  final portfolioBloc = PortfolioBloc(
    PortfolioRepository(
      firebaseFirestore: FirebaseFirestore.instance,
      dio: Dio(),
      tokenRepository: TokenRepository(
        dio: Dio(),
        coingeckoDatasource: CoingeckoDatasource(),
        firebaseFirestore: FirebaseFirestore.instance,
        pancakeswapDatasource: PancakeswapDatasource(),
      ),
    ),
  );

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      portfolioBloc.add(FetchTokensPortfolioEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return TemplateContainerWidget(
      title: 'Criptomoedas',
      subtitle: 'Cadastre suas criptomoedas',
      size: size,
      isExit: true,
      isOptions: true,
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 400,
            child: BlocBuilder<PortfolioBloc, PortfolioState>(
              bloc: portfolioBloc,
              builder: (context, state) {
                if (state is LoadingPortfolioState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (state is ErrorPortfolioState) {
                  return const Center(
                    child: Text('Houve um erro grave.'),
                  );
                }

                if (state is SuccessPortfolioState) {
                  return GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemCount: state.tokens.length + 1,
                    itemBuilder: (ctx, index) {
                      if (state.tokens.length == index) {
                        return GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (ctx) {
                                return const CriptoDialogWidget(
                                  title: 'Cadastrar Cripto',
                                  subtitle: 'Digite o símbolo ou endereço da cripto para realizar a busca',
                                );
                              },
                            ).then((value) => portfolioBloc.add(FetchTokensPortfolioEvent()));
                          },
                          child: Container(
                            margin: const EdgeInsets.all(6.5),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.secondary,
                              borderRadius: BorderRadius.circular(25),
                              border: Border.all(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                            child: Icon(
                              Icons.add,
                              size: 40,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        );
                      }
                      return Padding(
                        padding: const EdgeInsets.all(6.5),
                        child: CardPriceWidget(
                          price: state.tokens[index].usdPrice ?? .0,
                          tokenTitle: state.tokens[index].name ?? '',
                          percentage: 100 -
                              ((state.tokens[index].last24price ?? 0) * 100) / (state.tokens[index].usdPrice ?? 1),
                          onTap: () => Navigator.of(context).pushNamed(
                            AppRoute.TOKEN_DETAIL,
                            arguments: state.tokens[index],
                          ),
                        ),
                      );
                    },
                  );
                }

                return const Center(
                  child: Text('Houve um erro grave.'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
