import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whallet/src/portifolio/bloc_portfolio/portfolio_bloc.dart';
import 'package:whallet/src/portifolio/bloc_portfolio/portfolio_event.dart';
import 'package:whallet/src/portifolio/bloc_portfolio/portfolio_state.dart';
import 'package:whallet/src/portifolio/repository/portfolio_repository.dart';
import 'package:whallet/src/portifolio/services/portfolio_service.dart';
import 'package:whallet/src/widgets/auth_header_container_widget.dart';
import 'package:whallet/src/widgets/card_price_widget.dart';
import 'package:whallet/src/widgets/cripto_dialog_widget.dart';

class PortfolioHomePage extends StatefulWidget {
  const PortfolioHomePage({Key? key}) : super(key: key);

  @override
  State<PortfolioHomePage> createState() => _PortfolioHomePageState();
}

class _PortfolioHomePageState extends State<PortfolioHomePage> {
  final portfolioBloc = PortfolioBloc(PortfolioService(PortfolioRepository()));
  late StreamSubscription sub;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      sub = portfolioBloc.stream.listen((event) => setState(() => {}));
      portfolioBloc.add(FetchTokensPortfolioEvent());
    });
  }

  @override
  void dispose() {
    super.dispose();
    sub.cancel();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return AuthHeaderContainerWidget(
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
                      crossAxisCount: 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
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
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.secondary,
                              borderRadius: BorderRadius.circular(25),
                              border: Border.all(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                            child: const Icon(
                              Icons.add,
                              size: 40,
                            ),
                          ),
                        );
                      }
                      return CardPriceWidget(
                        price: state.tokens[index].usdPrice ?? .0,
                        tokenTitle: state.tokens[index].name ?? '',
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
