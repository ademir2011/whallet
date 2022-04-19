import 'package:whallet/src/portifolio/domain/entities/token_entity.dart';

abstract class IGetLast24TokenPricesRepository {
  Future<List<double>> getLast24TokenPrices({required TokenEntity tokenEntity});
}
