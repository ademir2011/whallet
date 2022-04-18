import 'package:whallet/src/portifolio/domain/entities/token_entity.dart';

abstract class ICreateTokenRepository {
  Future<void> createToken({required TokenEntity tokenEntity});
}
