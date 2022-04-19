import 'package:whallet/src/portifolio/domain/entities/token_entity.dart';
import 'package:whallet/src/portifolio/domain/repositories/get_last_24_token_prices_repository_interface.dart';

abstract class IGetLast24TokenPrices {
  Future<List<double>> getLast24TokenPrices({required TokenEntity tokenEntity});
}

class GetLast24TokenPrices implements IGetLast24TokenPrices {
  final IGetLast24TokenPricesRepository iGetLast24TokenPricesRepository;

  GetLast24TokenPrices({required this.iGetLast24TokenPricesRepository});

  @override
  Future<List<double>> getLast24TokenPrices({required TokenEntity tokenEntity}) async {
    return await iGetLast24TokenPricesRepository.getLast24TokenPrices(tokenEntity: tokenEntity);
  }
}
