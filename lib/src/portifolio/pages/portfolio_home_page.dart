import 'package:flutter/material.dart';
import 'package:whallet/src/portifolio/stores/cripto_store.dart';
import 'package:whallet/src/portifolio/stores/portfolio_home_store.dart';
import 'package:whallet/src/widgets/auth_header_container_widget.dart';
import 'package:whallet/src/widgets/card_price_widget.dart';
import 'package:whallet/src/widgets/cripto_dialog_widget.dart';

class PortfolioHomePage extends StatefulWidget {
  const PortfolioHomePage({Key? key}) : super(key: key);

  @override
  State<PortfolioHomePage> createState() => _PortfolioHomePageState();
}

class _PortfolioHomePageState extends State<PortfolioHomePage> {
  final portfolioHomeStore = PortfolioHomeStore();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    portfolioHomeStore.addListener(() => setState(() {}));
    portfolioHomeStore.getTokensByUser();
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
            child: portfolioHomeStore.isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: portfolioHomeStore.tokens.length + 1,
                    itemBuilder: (ctx, index) {
                      if (portfolioHomeStore.tokens.length == index) {
                        return GestureDetector(
                          onTap: () {
                            final criptoStore = CriptoStore();
                            showDialog(
                              context: context,
                              builder: (ctx) {
                                return CriptoDialogWidget(
                                  criptoStore: criptoStore,
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
                        price: portfolioHomeStore.tokens[index].usdPrice ?? .0,
                        tokenTitle: portfolioHomeStore.tokens[index].name ?? '',
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
