import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:whallet/src/portifolio/bloc_token/token_bloc.dart';
import 'package:whallet/src/portifolio/bloc_token/token_event.dart';
import 'package:whallet/src/portifolio/bloc_token/token_state.dart';
import 'package:whallet/src/portifolio/datasources/coingecko_datasource.dart';
import 'package:whallet/src/portifolio/datasources/pancakeswap_datasource.dart';
import 'package:whallet/src/portifolio/models/token_model.dart';
import 'package:whallet/src/portifolio/repository/token_repository.dart';
import 'package:whallet/src/widgets/elevated_button_widget.dart';
import 'package:whallet/src/widgets/generic_card_primary_widget.dart';
import 'package:whallet/src/widgets/generic_card_secondary_widget.dart';
import 'package:whallet/src/widgets/icon_button_widget.dart';
import 'package:whallet/src/widgets/outlined_button_widget.dart';
import 'package:whallet/src/widgets/template_container_widget.dart';
import 'package:whallet/utils/change_theme.dart';
import 'package:whallet/utils/routes.dart';

class TokenDetailPage extends StatefulWidget {
  const TokenDetailPage({Key? key}) : super(key: key);

  @override
  State<TokenDetailPage> createState() => _TokenDetailPageState();
}

class _TokenDetailPageState extends State<TokenDetailPage> {
  late TokenModel tokenModel;

  final tokenBloc = TokenBloc(
    tokenRepository: TokenRepository(
      coingeckoDatasource: CoingeckoDatasource(),
      pancakeswapDatasource: PancakeswapDatasource(),
      dio: Dio(),
      firebaseFirestore: FirebaseFirestore.instance,
    ),
  );

  @override
  void didChangeDependencies() {
    tokenModel = ModalRoute.of(context)!.settings.arguments as TokenModel;
    super.didChangeDependencies();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      tokenBloc.add(FetchDetailTokenEvent(tokenModel: tokenModel));
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return TemplateContainerWidget(
      isExit: true,
      isOptions: true,
      size: size,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 30),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                (tokenModel.symbol ?? '').toUpperCase(),
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 25,
                      fontWeight: FontWeight.w800,
                    ),
              ),
              const SizedBox(width: 10),
              Text('( ${tokenModel.name} )'),
              const Spacer(),
              Text(
                '\$ ${(tokenModel.usdPrice ?? .0).truncate()}',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 25,
                      fontWeight: FontWeight.w800,
                    ),
              ),
              Text(
                  '.${(tokenModel.usdPrice! - tokenModel.usdPrice!.truncate().toDouble()).toStringAsFixed(8).split('.')[1]}'),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 300,
            child: BlocBuilder<TokenBloc, TokenState>(
              bloc: tokenBloc,
              builder: (ctx, state) {
                if (state is ErrorTokenState) {
                  return Center(
                    child: Text(state.message),
                  );
                }

                if (state is LoadingTokenState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (state is SuccessTokenFetchState) {
                  return SfChartTheme(
                    data: SfChartThemeData(
                      brightness: Provider.of<ChangeTheme>(context).switchTheme ? Brightness.light : Brightness.dark,
                      axisLineColor: Colors.transparent,
                      plotAreaBorderColor: Colors.transparent,
                      majorTickLineColor: Colors.transparent,
                      majorGridLineColor: Colors.transparent,
                    ),
                    child: SfCartesianChart(
                      enableAxisAnimation: true,
                      primaryXAxis: CategoryAxis(),
                      series: <ChartSeries>[
                        SplineSeries<double, String>(
                          dataSource: state.tokenModel.lastHourPrices!,
                          xValueMapper: (double tokenPrices, index) {
                            final date =
                                state.tokenModel.updatedAtTokenValue!.subtract(Duration(minutes: 60 - (index * 5)));
                            return '${date.hour}:${date.minute}';
                          },
                          yValueMapper: (double tokenPrices, _) => tokenPrices,
                          dataLabelSettings: const DataLabelSettings(isVisible: true),
                          color: Theme.of(context).colorScheme.primary,
                        )
                      ],
                    ),
                  );
                }

                return Container();
              },
            ),
          ),
          const SizedBox(height: 20),
          const GenericCardPrimaryWidget(title: 'Wallet'),
          const SizedBox(height: 20),
          GenericCardSecondary(
            child: Row(children: [
              const SizedBox(width: 10),
              IconButtonWidget(
                color: Theme.of(context).colorScheme.error,
                icon: Icons.delete,
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (ctx) {
                      return BlocListener(
                        bloc: tokenBloc,
                        listener: (ctx, state) {
                          if (state is SuccessTokenRemoveState) Navigator.of(ctx).pushNamed(AppRoute.PORTFOLIO_HOME);
                        },
                        child: BlocBuilder<TokenBloc, TokenState>(
                          bloc: tokenBloc,
                          builder: (ctx, state) => AlertDialog(
                            title: const Text('Tem certeza que deseja deletar ?'),
                            content: Text((state is ErrorTokenState)
                                ? 'Erro ao deletar'
                                : (state is SuccessTokenRemoveState)
                                    ? 'Token removido com sucesso'
                                    : ''),
                            actions: [
                              OutlinedButtonWidget(
                                title: 'Fechar',
                                onPressed: () => Navigator.of(ctx).pop(),
                              ),
                              ElevatedButtonWidget(
                                onPressed: () {
                                  tokenBloc.add(RemoveTokenEvent(tokenModel: tokenModel));
                                },
                                isLoading: state is LoadingTokenState,
                                title: 'SIM',
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
              const Spacer(),
              Row(
                children: [
                  Text(tokenModel.usdPrice.toString()),
                  const SizedBox(width: 5),
                  Text(tokenModel.symbol ?? ''),
                ],
              )
            ]),
          )
        ],
      ),
    );
  }
}
